import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

    /// The "AccentColor" asset catalog color resource.
    static let accent = DeveloperToolsSupport.ColorResource(name: "AccentColor", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

    /// The "A220-300" asset catalog image resource.
    static let A_220_300 = DeveloperToolsSupport.ImageResource(name: "A220-300", bundle: resourceBundle)

    /// The "A318" asset catalog image resource.
    static let A_318 = DeveloperToolsSupport.ImageResource(name: "A318", bundle: resourceBundle)

    /// The "A319" asset catalog image resource.
    static let A_319 = DeveloperToolsSupport.ImageResource(name: "A319", bundle: resourceBundle)

    /// The "A319neo" asset catalog image resource.
    static let a319Neo = DeveloperToolsSupport.ImageResource(name: "A319neo", bundle: resourceBundle)

    /// The "A320" asset catalog image resource.
    static let A_320 = DeveloperToolsSupport.ImageResource(name: "A320", bundle: resourceBundle)

    /// The "A320neo" asset catalog image resource.
    static let a320Neo = DeveloperToolsSupport.ImageResource(name: "A320neo", bundle: resourceBundle)

    /// The "A321" asset catalog image resource.
    static let A_321 = DeveloperToolsSupport.ImageResource(name: "A321", bundle: resourceBundle)

    /// The "A321neo" asset catalog image resource.
    static let a321Neo = DeveloperToolsSupport.ImageResource(name: "A321neo", bundle: resourceBundle)

    /// The "A330-300" asset catalog image resource.
    static let A_330_300 = DeveloperToolsSupport.ImageResource(name: "A330-300", bundle: resourceBundle)

    /// The "A330neo-900" asset catalog image resource.
    static let a330Neo900 = DeveloperToolsSupport.ImageResource(name: "A330neo-900", bundle: resourceBundle)

    /// The "A340-300" asset catalog image resource.
    static let A_340_300 = DeveloperToolsSupport.ImageResource(name: "A340-300", bundle: resourceBundle)

    /// The "A340-600" asset catalog image resource.
    static let A_340_600 = DeveloperToolsSupport.ImageResource(name: "A340-600", bundle: resourceBundle)

    /// The "A350-1000" asset catalog image resource.
    static let A_350_1000 = DeveloperToolsSupport.ImageResource(name: "A350-1000", bundle: resourceBundle)

    /// The "A350-900" asset catalog image resource.
    static let A_350_900 = DeveloperToolsSupport.ImageResource(name: "A350-900", bundle: resourceBundle)

    /// The "A380-800" asset catalog image resource.
    static let A_380_800 = DeveloperToolsSupport.ImageResource(name: "A380-800", bundle: resourceBundle)

    /// The "ATR42" asset catalog image resource.
    static let ATR_42 = DeveloperToolsSupport.ImageResource(name: "ATR42", bundle: resourceBundle)

    /// The "ATR72" asset catalog image resource.
    static let ATR_72 = DeveloperToolsSupport.ImageResource(name: "ATR72", bundle: resourceBundle)

    /// The "AboutIcon" asset catalog image resource.
    static let aboutIcon = DeveloperToolsSupport.ImageResource(name: "AboutIcon", bundle: resourceBundle)

    /// The "B707-320C" asset catalog image resource.
    static let B_707_320_C = DeveloperToolsSupport.ImageResource(name: "B707-320C", bundle: resourceBundle)

    /// The "B717-200" asset catalog image resource.
    static let B_717_200 = DeveloperToolsSupport.ImageResource(name: "B717-200", bundle: resourceBundle)

    /// The "B727-200" asset catalog image resource.
    static let B_727_200 = DeveloperToolsSupport.ImageResource(name: "B727-200", bundle: resourceBundle)

    /// The "B737-200ADV" asset catalog image resource.
    static let B_737_200_ADV = DeveloperToolsSupport.ImageResource(name: "B737-200ADV", bundle: resourceBundle)

    /// The "B737-300" asset catalog image resource.
    static let B_737_300 = DeveloperToolsSupport.ImageResource(name: "B737-300", bundle: resourceBundle)

    /// The "B737-800NG" asset catalog image resource.
    static let B_737_800_NG = DeveloperToolsSupport.ImageResource(name: "B737-800NG", bundle: resourceBundle)

    /// The "B737MAX8" asset catalog image resource.
    static let B_737_MAX_8 = DeveloperToolsSupport.ImageResource(name: "B737MAX8", bundle: resourceBundle)

    /// The "B737MAX9" asset catalog image resource.
    static let B_737_MAX_9 = DeveloperToolsSupport.ImageResource(name: "B737MAX9", bundle: resourceBundle)

    /// The "B747-100" asset catalog image resource.
    static let B_747_100 = DeveloperToolsSupport.ImageResource(name: "B747-100", bundle: resourceBundle)

    /// The "B747-200C" asset catalog image resource.
    static let B_747_200_C = DeveloperToolsSupport.ImageResource(name: "B747-200C", bundle: resourceBundle)

    /// The "B747-400" asset catalog image resource.
    static let B_747_400 = DeveloperToolsSupport.ImageResource(name: "B747-400", bundle: resourceBundle)

    /// The "B747-8I" asset catalog image resource.
    static let B_747_8_I = DeveloperToolsSupport.ImageResource(name: "B747-8I", bundle: resourceBundle)

    /// The "B757-200" asset catalog image resource.
    static let B_757_200 = DeveloperToolsSupport.ImageResource(name: "B757-200", bundle: resourceBundle)

    /// The "B767-300ER" asset catalog image resource.
    static let B_767_300_ER = DeveloperToolsSupport.ImageResource(name: "B767-300ER", bundle: resourceBundle)

    /// The "B777-300ER" asset catalog image resource.
    static let B_777_300_ER = DeveloperToolsSupport.ImageResource(name: "B777-300ER", bundle: resourceBundle)

    /// The "B777X-9" asset catalog image resource.
    static let B_777_X_9 = DeveloperToolsSupport.ImageResource(name: "B777X-9", bundle: resourceBundle)

    /// The "B787-10" asset catalog image resource.
    static let B_787_10 = DeveloperToolsSupport.ImageResource(name: "B787-10", bundle: resourceBundle)

    /// The "B787-9" asset catalog image resource.
    static let B_787_9 = DeveloperToolsSupport.ImageResource(name: "B787-9", bundle: resourceBundle)

    /// The "CONCORDE" asset catalog image resource.
    static let CONCORDE = DeveloperToolsSupport.ImageResource(name: "CONCORDE", bundle: resourceBundle)

    /// The "CRJ900" asset catalog image resource.
    static let CRJ_900 = DeveloperToolsSupport.ImageResource(name: "CRJ900", bundle: resourceBundle)

    /// The "DC10-30" asset catalog image resource.
    static let DC_10_30 = DeveloperToolsSupport.ImageResource(name: "DC10-30", bundle: resourceBundle)

    /// The "DC9-31" asset catalog image resource.
    static let DC_9_31 = DeveloperToolsSupport.ImageResource(name: "DC9-31", bundle: resourceBundle)

    /// The "DHC6" asset catalog image resource.
    static let DHC_6 = DeveloperToolsSupport.ImageResource(name: "DHC6", bundle: resourceBundle)

    /// The "DHC8" asset catalog image resource.
    static let DHC_8 = DeveloperToolsSupport.ImageResource(name: "DHC8", bundle: resourceBundle)

    /// The "E175E2" asset catalog image resource.
    static let E_175_E_2 = DeveloperToolsSupport.ImageResource(name: "E175E2", bundle: resourceBundle)

    /// The "E190E2" asset catalog image resource.
    static let E_190_E_2 = DeveloperToolsSupport.ImageResource(name: "E190E2", bundle: resourceBundle)

    /// The "ERJ145" asset catalog image resource.
    static let ERJ_145 = DeveloperToolsSupport.ImageResource(name: "ERJ145", bundle: resourceBundle)

    /// The "ERJ170" asset catalog image resource.
    static let ERJ_170 = DeveloperToolsSupport.ImageResource(name: "ERJ170", bundle: resourceBundle)

    /// The "ERJ190" asset catalog image resource.
    static let ERJ_190 = DeveloperToolsSupport.ImageResource(name: "ERJ190", bundle: resourceBundle)

    /// The "GithubLogo" asset catalog image resource.
    static let githubLogo = DeveloperToolsSupport.ImageResource(name: "GithubLogo", bundle: resourceBundle)

    /// The "IL96-400M" asset catalog image resource.
    static let IL_96_400_M = DeveloperToolsSupport.ImageResource(name: "IL96-400M", bundle: resourceBundle)

    /// The "MC21-300" asset catalog image resource.
    static let MC_21_300 = DeveloperToolsSupport.ImageResource(name: "MC21-300", bundle: resourceBundle)

    /// The "MD11" asset catalog image resource.
    static let MD_11 = DeveloperToolsSupport.ImageResource(name: "MD11", bundle: resourceBundle)

    /// The "MD82" asset catalog image resource.
    static let MD_82 = DeveloperToolsSupport.ImageResource(name: "MD82", bundle: resourceBundle)

    /// The "Normal" asset catalog image resource.
    static let normal = DeveloperToolsSupport.ImageResource(name: "Normal", bundle: resourceBundle)

    /// The "SSJ100" asset catalog image resource.
    static let SSJ_100 = DeveloperToolsSupport.ImageResource(name: "SSJ100", bundle: resourceBundle)

    /// The "Satelite" asset catalog image resource.
    static let satelite = DeveloperToolsSupport.ImageResource(name: "Satelite", bundle: resourceBundle)

    /// The "TU144" asset catalog image resource.
    static let TU_144 = DeveloperToolsSupport.ImageResource(name: "TU144", bundle: resourceBundle)

    /// The "TU204SM" asset catalog image resource.
    static let TU_204_SM = DeveloperToolsSupport.ImageResource(name: "TU204SM", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "AccentColor" asset catalog color.
    static var accent: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .accent)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "AccentColor" asset catalog color.
    static var accent: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .accent)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    /// The "AccentColor" asset catalog color.
    static var accent: SwiftUI.Color { .init(.accent) }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "AccentColor" asset catalog color.
    static var accent: SwiftUI.Color { .init(.accent) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "A220-300" asset catalog image.
    static var A_220_300: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_220_300)
#else
        .init()
#endif
    }

    /// The "A318" asset catalog image.
    static var A_318: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_318)
#else
        .init()
#endif
    }

    /// The "A319" asset catalog image.
    static var A_319: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_319)
#else
        .init()
#endif
    }

    /// The "A319neo" asset catalog image.
    static var a319Neo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .a319Neo)
#else
        .init()
#endif
    }

    /// The "A320" asset catalog image.
    static var A_320: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_320)
#else
        .init()
#endif
    }

    /// The "A320neo" asset catalog image.
    static var a320Neo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .a320Neo)
#else
        .init()
#endif
    }

    /// The "A321" asset catalog image.
    static var A_321: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_321)
#else
        .init()
#endif
    }

    /// The "A321neo" asset catalog image.
    static var a321Neo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .a321Neo)
#else
        .init()
#endif
    }

    /// The "A330-300" asset catalog image.
    static var A_330_300: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_330_300)
#else
        .init()
#endif
    }

    /// The "A330neo-900" asset catalog image.
    static var a330Neo900: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .a330Neo900)
#else
        .init()
#endif
    }

    /// The "A340-300" asset catalog image.
    static var A_340_300: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_340_300)
#else
        .init()
#endif
    }

    /// The "A340-600" asset catalog image.
    static var A_340_600: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_340_600)
#else
        .init()
#endif
    }

    /// The "A350-1000" asset catalog image.
    static var A_350_1000: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_350_1000)
#else
        .init()
#endif
    }

    /// The "A350-900" asset catalog image.
    static var A_350_900: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_350_900)
#else
        .init()
#endif
    }

    /// The "A380-800" asset catalog image.
    static var A_380_800: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .A_380_800)
#else
        .init()
#endif
    }

    /// The "ATR42" asset catalog image.
    static var ATR_42: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ATR_42)
#else
        .init()
#endif
    }

    /// The "ATR72" asset catalog image.
    static var ATR_72: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ATR_72)
#else
        .init()
#endif
    }

    /// The "AboutIcon" asset catalog image.
    static var aboutIcon: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .aboutIcon)
#else
        .init()
#endif
    }

    /// The "B707-320C" asset catalog image.
    static var B_707_320_C: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_707_320_C)
#else
        .init()
#endif
    }

    /// The "B717-200" asset catalog image.
    static var B_717_200: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_717_200)
#else
        .init()
#endif
    }

    /// The "B727-200" asset catalog image.
    static var B_727_200: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_727_200)
#else
        .init()
#endif
    }

    /// The "B737-200ADV" asset catalog image.
    static var B_737_200_ADV: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_737_200_ADV)
#else
        .init()
#endif
    }

    /// The "B737-300" asset catalog image.
    static var B_737_300: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_737_300)
#else
        .init()
#endif
    }

    /// The "B737-800NG" asset catalog image.
    static var B_737_800_NG: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_737_800_NG)
#else
        .init()
#endif
    }

    /// The "B737MAX8" asset catalog image.
    static var B_737_MAX_8: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_737_MAX_8)
#else
        .init()
#endif
    }

    /// The "B737MAX9" asset catalog image.
    static var B_737_MAX_9: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_737_MAX_9)
#else
        .init()
#endif
    }

    /// The "B747-100" asset catalog image.
    static var B_747_100: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_747_100)
#else
        .init()
#endif
    }

    /// The "B747-200C" asset catalog image.
    static var B_747_200_C: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_747_200_C)
#else
        .init()
#endif
    }

    /// The "B747-400" asset catalog image.
    static var B_747_400: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_747_400)
#else
        .init()
#endif
    }

    /// The "B747-8I" asset catalog image.
    static var B_747_8_I: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_747_8_I)
#else
        .init()
#endif
    }

    /// The "B757-200" asset catalog image.
    static var B_757_200: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_757_200)
#else
        .init()
#endif
    }

    /// The "B767-300ER" asset catalog image.
    static var B_767_300_ER: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_767_300_ER)
#else
        .init()
#endif
    }

    /// The "B777-300ER" asset catalog image.
    static var B_777_300_ER: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_777_300_ER)
#else
        .init()
#endif
    }

    /// The "B777X-9" asset catalog image.
    static var B_777_X_9: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_777_X_9)
#else
        .init()
#endif
    }

    /// The "B787-10" asset catalog image.
    static var B_787_10: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_787_10)
#else
        .init()
#endif
    }

    /// The "B787-9" asset catalog image.
    static var B_787_9: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .B_787_9)
#else
        .init()
#endif
    }

    /// The "CONCORDE" asset catalog image.
    static var CONCORDE: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .CONCORDE)
#else
        .init()
#endif
    }

    /// The "CRJ900" asset catalog image.
    static var CRJ_900: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .CRJ_900)
#else
        .init()
#endif
    }

    /// The "DC10-30" asset catalog image.
    static var DC_10_30: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .DC_10_30)
#else
        .init()
#endif
    }

    /// The "DC9-31" asset catalog image.
    static var DC_9_31: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .DC_9_31)
#else
        .init()
#endif
    }

    /// The "DHC6" asset catalog image.
    static var DHC_6: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .DHC_6)
#else
        .init()
#endif
    }

    /// The "DHC8" asset catalog image.
    static var DHC_8: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .DHC_8)
#else
        .init()
#endif
    }

    /// The "E175E2" asset catalog image.
    static var E_175_E_2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .E_175_E_2)
#else
        .init()
#endif
    }

    /// The "E190E2" asset catalog image.
    static var E_190_E_2: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .E_190_E_2)
#else
        .init()
#endif
    }

    /// The "ERJ145" asset catalog image.
    static var ERJ_145: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ERJ_145)
#else
        .init()
#endif
    }

    /// The "ERJ170" asset catalog image.
    static var ERJ_170: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ERJ_170)
#else
        .init()
#endif
    }

    /// The "ERJ190" asset catalog image.
    static var ERJ_190: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ERJ_190)
#else
        .init()
#endif
    }

    /// The "GithubLogo" asset catalog image.
    static var githubLogo: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .githubLogo)
#else
        .init()
#endif
    }

    /// The "IL96-400M" asset catalog image.
    static var IL_96_400_M: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .IL_96_400_M)
#else
        .init()
#endif
    }

    /// The "MC21-300" asset catalog image.
    static var MC_21_300: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .MC_21_300)
#else
        .init()
#endif
    }

    /// The "MD11" asset catalog image.
    static var MD_11: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .MD_11)
#else
        .init()
#endif
    }

    /// The "MD82" asset catalog image.
    static var MD_82: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .MD_82)
#else
        .init()
#endif
    }

    /// The "Normal" asset catalog image.
    static var normal: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .normal)
#else
        .init()
#endif
    }

    /// The "SSJ100" asset catalog image.
    static var SSJ_100: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .SSJ_100)
#else
        .init()
#endif
    }

    /// The "Satelite" asset catalog image.
    static var satelite: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .satelite)
#else
        .init()
#endif
    }

    /// The "TU144" asset catalog image.
    static var TU_144: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .TU_144)
#else
        .init()
#endif
    }

    /// The "TU204SM" asset catalog image.
    static var TU_204_SM: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .TU_204_SM)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "A220-300" asset catalog image.
    static var A_220_300: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_220_300)
#else
        .init()
#endif
    }

    /// The "A318" asset catalog image.
    static var A_318: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_318)
#else
        .init()
#endif
    }

    /// The "A319" asset catalog image.
    static var A_319: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_319)
#else
        .init()
#endif
    }

    /// The "A319neo" asset catalog image.
    static var a319Neo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .a319Neo)
#else
        .init()
#endif
    }

    /// The "A320" asset catalog image.
    static var A_320: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_320)
#else
        .init()
#endif
    }

    /// The "A320neo" asset catalog image.
    static var a320Neo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .a320Neo)
#else
        .init()
#endif
    }

    /// The "A321" asset catalog image.
    static var A_321: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_321)
#else
        .init()
#endif
    }

    /// The "A321neo" asset catalog image.
    static var a321Neo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .a321Neo)
#else
        .init()
#endif
    }

    /// The "A330-300" asset catalog image.
    static var A_330_300: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_330_300)
#else
        .init()
#endif
    }

    /// The "A330neo-900" asset catalog image.
    static var a330Neo900: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .a330Neo900)
#else
        .init()
#endif
    }

    /// The "A340-300" asset catalog image.
    static var A_340_300: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_340_300)
#else
        .init()
#endif
    }

    /// The "A340-600" asset catalog image.
    static var A_340_600: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_340_600)
#else
        .init()
#endif
    }

    /// The "A350-1000" asset catalog image.
    static var A_350_1000: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_350_1000)
#else
        .init()
#endif
    }

    /// The "A350-900" asset catalog image.
    static var A_350_900: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_350_900)
#else
        .init()
#endif
    }

    /// The "A380-800" asset catalog image.
    static var A_380_800: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .A_380_800)
#else
        .init()
#endif
    }

    /// The "ATR42" asset catalog image.
    static var ATR_42: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ATR_42)
#else
        .init()
#endif
    }

    /// The "ATR72" asset catalog image.
    static var ATR_72: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ATR_72)
#else
        .init()
#endif
    }

    /// The "AboutIcon" asset catalog image.
    static var aboutIcon: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .aboutIcon)
#else
        .init()
#endif
    }

    /// The "B707-320C" asset catalog image.
    static var B_707_320_C: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_707_320_C)
#else
        .init()
#endif
    }

    /// The "B717-200" asset catalog image.
    static var B_717_200: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_717_200)
#else
        .init()
#endif
    }

    /// The "B727-200" asset catalog image.
    static var B_727_200: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_727_200)
#else
        .init()
#endif
    }

    /// The "B737-200ADV" asset catalog image.
    static var B_737_200_ADV: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_737_200_ADV)
#else
        .init()
#endif
    }

    /// The "B737-300" asset catalog image.
    static var B_737_300: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_737_300)
#else
        .init()
#endif
    }

    /// The "B737-800NG" asset catalog image.
    static var B_737_800_NG: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_737_800_NG)
#else
        .init()
#endif
    }

    /// The "B737MAX8" asset catalog image.
    static var B_737_MAX_8: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_737_MAX_8)
#else
        .init()
#endif
    }

    /// The "B737MAX9" asset catalog image.
    static var B_737_MAX_9: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_737_MAX_9)
#else
        .init()
#endif
    }

    /// The "B747-100" asset catalog image.
    static var B_747_100: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_747_100)
#else
        .init()
#endif
    }

    /// The "B747-200C" asset catalog image.
    static var B_747_200_C: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_747_200_C)
#else
        .init()
#endif
    }

    /// The "B747-400" asset catalog image.
    static var B_747_400: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_747_400)
#else
        .init()
#endif
    }

    /// The "B747-8I" asset catalog image.
    static var B_747_8_I: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_747_8_I)
#else
        .init()
#endif
    }

    /// The "B757-200" asset catalog image.
    static var B_757_200: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_757_200)
#else
        .init()
#endif
    }

    /// The "B767-300ER" asset catalog image.
    static var B_767_300_ER: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_767_300_ER)
#else
        .init()
#endif
    }

    /// The "B777-300ER" asset catalog image.
    static var B_777_300_ER: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_777_300_ER)
#else
        .init()
#endif
    }

    /// The "B777X-9" asset catalog image.
    static var B_777_X_9: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_777_X_9)
#else
        .init()
#endif
    }

    /// The "B787-10" asset catalog image.
    static var B_787_10: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_787_10)
#else
        .init()
#endif
    }

    /// The "B787-9" asset catalog image.
    static var B_787_9: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .B_787_9)
#else
        .init()
#endif
    }

    /// The "CONCORDE" asset catalog image.
    static var CONCORDE: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .CONCORDE)
#else
        .init()
#endif
    }

    /// The "CRJ900" asset catalog image.
    static var CRJ_900: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .CRJ_900)
#else
        .init()
#endif
    }

    /// The "DC10-30" asset catalog image.
    static var DC_10_30: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .DC_10_30)
#else
        .init()
#endif
    }

    /// The "DC9-31" asset catalog image.
    static var DC_9_31: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .DC_9_31)
#else
        .init()
#endif
    }

    /// The "DHC6" asset catalog image.
    static var DHC_6: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .DHC_6)
#else
        .init()
#endif
    }

    /// The "DHC8" asset catalog image.
    static var DHC_8: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .DHC_8)
#else
        .init()
#endif
    }

    /// The "E175E2" asset catalog image.
    static var E_175_E_2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .E_175_E_2)
#else
        .init()
#endif
    }

    /// The "E190E2" asset catalog image.
    static var E_190_E_2: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .E_190_E_2)
#else
        .init()
#endif
    }

    /// The "ERJ145" asset catalog image.
    static var ERJ_145: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ERJ_145)
#else
        .init()
#endif
    }

    /// The "ERJ170" asset catalog image.
    static var ERJ_170: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ERJ_170)
#else
        .init()
#endif
    }

    /// The "ERJ190" asset catalog image.
    static var ERJ_190: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .ERJ_190)
#else
        .init()
#endif
    }

    /// The "GithubLogo" asset catalog image.
    static var githubLogo: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .githubLogo)
#else
        .init()
#endif
    }

    /// The "IL96-400M" asset catalog image.
    static var IL_96_400_M: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .IL_96_400_M)
#else
        .init()
#endif
    }

    /// The "MC21-300" asset catalog image.
    static var MC_21_300: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .MC_21_300)
#else
        .init()
#endif
    }

    /// The "MD11" asset catalog image.
    static var MD_11: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .MD_11)
#else
        .init()
#endif
    }

    /// The "MD82" asset catalog image.
    static var MD_82: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .MD_82)
#else
        .init()
#endif
    }

    /// The "Normal" asset catalog image.
    static var normal: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .normal)
#else
        .init()
#endif
    }

    /// The "SSJ100" asset catalog image.
    static var SSJ_100: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .SSJ_100)
#else
        .init()
#endif
    }

    /// The "Satelite" asset catalog image.
    static var satelite: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .satelite)
#else
        .init()
#endif
    }

    /// The "TU144" asset catalog image.
    static var TU_144: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .TU_144)
#else
        .init()
#endif
    }

    /// The "TU204SM" asset catalog image.
    static var TU_204_SM: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .TU_204_SM)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

