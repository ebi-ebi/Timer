//
//  TimerHelper.swift
//  Timer
//
//  Created by billy on 10/5/23.
//

import Foundation

struct TimerHelper {
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
}
