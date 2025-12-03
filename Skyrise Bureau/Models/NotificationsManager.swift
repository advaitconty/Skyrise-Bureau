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
}

class NotificationsManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationsManager()
    private let center = UNUserNotificationCenter.current()
    
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
                content.title = "\(planeInvolved!.aircraftname) (\(planeInvolved!.registration)) has just landed at \(planeInvolved!.assignedRoute!.arrivalAirport)!"
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
    
    func removeAll() {
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
    
    func returnAllNotificationScheduledForStatsForNerds() -> [NotificationItem] {
        var notificationItemsList: [NotificationItem] = []
        center.getPendingNotificationRequests { requests in
            for request in requests {
                var itemToAppend: NotificationItem = NotificationItem(notificationTitle: request.content.title, notificationBody: request.content.body, notificationSendTime: Date())
                if let trigger = request.trigger as? UNCalendarNotificationTrigger {
                    itemToAppend.notificationSendTime = trigger.nextTriggerDate() ?? Date()
                } else if let trigger = request.trigger as? UNTimeIntervalNotificationTrigger {
                    print("Scheduled in: \(trigger.timeInterval) seconds")
                }
                notificationItemsList.append(itemToAppend)
            }
        }
        return notificationItemsList
    }
}
