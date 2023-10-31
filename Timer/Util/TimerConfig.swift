//
//  TimerConfig.swift
//  Timer
//
//  Created by billy on 10/30/23.
//

import Foundation

struct TimerConfig {
    static var myTimerConfig: TimerConfig?
    
    var config: [String: Any]?
    
    static func currentConfig() -> TimerConfig {
        if let timerConfig = TimerConfig.myTimerConfig {
            return timerConfig
        } else {
            let timerConfig = TimerConfig()
            self.myTimerConfig = timerConfig
            return timerConfig
        }
    }
    
    init() {
        var config: [String: Any]?

        if let infoPlistPath = Bundle.main.url(forResource: "Config", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }

        self.config = config
    }
    
    func boolValueForKey(str: String) -> Bool {
        if let config = config,
            let value = config[str] as? Bool {
            return value
        }
        print("Config value not found \(str)")
        return false
    }
    
    func notificationEnabled() -> Bool {
        return boolValueForKey(str: "NotificationEnabled")
    }
}
