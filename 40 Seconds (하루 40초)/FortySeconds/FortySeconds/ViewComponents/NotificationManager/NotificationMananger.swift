//
//  NotificationMananger.swift
//  FortySeconds
//
//  Created by Jinho Lee on 3/2/22.
//

import SwiftUI
import UserNotifications

class NotificationManager {
    static let notification = NotificationManager()
    @AppStorage("notificationAsked") var notificationAsked = false
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) {
            success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
                self.notificationAsked = true
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "다시 하루 40초를 플레이 할 수 있어요!"
        content.subtitle = "준비되셨나요?"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 86400, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
