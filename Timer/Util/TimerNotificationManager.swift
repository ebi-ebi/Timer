//
//  TimerNotificationManager.swift
//  Timer
//
//  Created by billy on 10/6/23.
//

import Foundation
import UserNotifications

struct TimerNotificationManager {
    private static var myManager: TimerNotificationManager?
    
    static func currentManager() -> TimerNotificationManager {
        if let currentManager = TimerNotificationManager.myManager {
            return currentManager
        } else {
            let manager = TimerNotificationManager()
            TimerNotificationManager.myManager = manager
            return manager
        }
    }
    
    func sendNotification(title:String, body:String, duration: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.interruptionLevel = .critical
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: duration, repeats: false)
        let uuidString =  UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            
        }
    }
    
    func cancelNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func requestForAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { _, _ in
            
        }
    }
}
