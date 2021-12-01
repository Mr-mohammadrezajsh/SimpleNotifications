//
//  Notifications.swift
//  SimpleNotifications
//
//  Created by Federico on 30/11/2021.
//

import Foundation
import UserNotifications

class Notifications {
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(date: Date, type: String) {
        if type == "date" {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)

            let dateTrigger = UNCalendarNotificationTrigger(
                     dateMatching: dateComponents, repeats: false)
            
            createNotification(trigger: dateTrigger)
        } else if type == "time" {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            createNotification(trigger: trigger)
        }
    }
    
    func createNotification(trigger: UNNotificationTrigger) {
        let content = UNMutableNotificationContent()
        content.title = "Epic Notification!"
        content.subtitle = "This came from an epic channel!"
        content.sound = UNNotificationSound.default

        // Create a request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // Add the notification request
        UNUserNotificationCenter.current().add(request)
    }
}
