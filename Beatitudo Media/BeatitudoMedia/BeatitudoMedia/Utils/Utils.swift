//
//  Utils.swift
//  BeatitudoMedia
//
//  Created by Jinho Lee on 5/17/24.
//

import Foundation
import UIKit


// MARK: - Device
final class Utils {
    // Device Related
    static func getiOSVersion() -> String {
        
        return UIDevice.current.systemVersion
    }
    
    static func getAppVersion() -> String? {
        
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}

// MARK: - Date
extension Utils {
    static func getAndClassifyCurrentHour() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 18..<24:
            return "기분 좋은 밤이에요."
        case 0..<7:
            return "선선한 새벽이에요."
        case 7..<12:
            return "좋은 아침이에요."
        case 12..<18:
            return "기운 넘치는 하루 되세요."
        default:
            return ""
        }
    }
    
    static func getToday() -> String {
        let calendar = Calendar.current
        
        let year: String = "\(calendar.component(.year, from: .now))년".replacingOccurrences(of: ",", with: "")
        let month: String = "\(calendar.component(.month, from: .now))월"
        let day: String = "\(calendar.component(.day, from: .now))일"
        
        return [year, month, day].joined(separator: " ")
    }
    
    @MainActor
    static func topViewController(controller: UIViewController? = nil) -> UIViewController? {
        let controller = controller ?? UIApplication.shared.keyWindow?.rootViewController
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

// MARK: - Enums
extension Utils {
    enum EmailSigningFocusField: Hashable {
        case email
        case passwordHidden
        case passwordShown
        case nickname
    }
}

// MARK: - Email
extension Utils {
    static func divideEmailIntoTokens(email: String) -> [String] {
        
        return email.split(separator: "@").map { String($0) }
    }
}
