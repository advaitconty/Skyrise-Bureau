//
//  NotificationsManager.swift
//  Skyrise Bureau
//
//  Created by Milind Contractor on 2/12/25.
//

import Foundation
import UserNotifications
import Combine

struct NotificationItem: Codable {
    var id = UUID()
    var notificationTitle: String
    var notificationBody: String
    var notificationSendTime: Date
    var formattedSendTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: notificationSendTime)
    }
}

class NotificationsManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationsManager()
    private let center = UNUserNotificationCenter.current()
    @Published var notifications: [NotificationItem] = []
    
    override init() {
        super.init()
        center.delegate = self
    }
    
    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("error")
            }
        }
    }
    
    func schedule(notificationType: AllowedNotificationTypes, planeInvolved: FleetItem?, date: Date, userData: UserData) {
        if userData.allowedNotificationTypes.contains(notificationType) {
            let content = UNMutableNotificationContent()
            switch notificationType {
            case .maintainanceEnd:
                content.title = "\(planeInvolved!.aircraftname) is ready to get back in the skies"
                content.body = "Depart your jet by hopping back on to Skyrise Bureau!"
            case .arrival:
                content.title = "\(planeInvolved!.aircraftname) (\(planeInvolved!.registration)) has just landed at \(planeInvolved!.assignedRoute!.arrivalAirport.reportCorrectCodeForUserData(userData))!"
                content.body = "Hop back on and keep it in the skies to maximise profits."
            case .campaignEnd:
                content.title = "Your marketing campaign has ended!"
                content.body = "Just a heads up!"
            }
            content.sound = .default
            
            let calender = Calendar.current
            let componenets = calender.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: componenets, repeats: false)
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
            
            center.add(request) { error in
                if let error = error {
                    print(error)
                } else {
                    print("scheduled")
                }
            }
        } else {
            print("notification type not allowed")
        }
    }
    
    func fetchPendingNotifications() async -> [NotificationItem] {
        await withCheckedContinuation { continuation in
            center.getPendingNotificationRequests { requests in
                let items = requests.map { request -> NotificationItem in
                    var item = NotificationItem(
                        notificationTitle: request.content.title,
                        notificationBody: request.content.body,
                        notificationSendTime: Date()
                    )
                    if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                        item.notificationSendTime = trigger.nextTriggerDate() ?? Date()
                    }
                    return item
                }
                DispatchQueue.main.async {
                    self.notifications = items
                }
                continuation.resume(returning: items)
            }
        }
    }
    
    /// DEBUG FUNCTIONS
    /// To remove all existing planned notifications
    func removeAll() {
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
}
