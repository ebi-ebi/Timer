//
//  TimerHelper.swift
//  Timer
//
//  Created by billy on 10/5/23.
//

import Foundation

struct TimerHelper {
    static let timeOptionsIncrements = [(5, 60), (15, 300), (60, 900), (300, 3600), (900, 18000), (3600, 86400)]
    
    static func formatDisplayStringForSeconds(_ time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        if (time >= 3600) {
            formatter.allowedUnits = [.hour, .minute, .second]
        } else {
            formatter.allowedUnits = [.minute, .second]
        }
        formatter.zeroFormattingBehavior = .pad
        formatter.unitsStyle = .positional
        
        guard let toReturn = formatter.string(from: time) else {
            return "Error"
        }

        return toReturn
    }
    
    static func formatDisplayStringForSubSecond(_ time: TimeInterval) -> String {
        guard time < 60 else {
            return ""
        }
        let subsecond = fmod(time, 1)
        return String(format: "%03.0f", subsecond * 1000)
    }
    
    static func getQuickTimeOptions() -> [TimerConfig] {
        var currentTime = 0
        var options: [Int] = Array()
        
        for (i, j) in timeOptionsIncrements {
            while (currentTime < j) {
                currentTime += i
                options.append(currentTime)
            }
        }
        return options.map { option -> TimerConfig in
            TimerConfig(time: Double(option))
        }
    }
}
