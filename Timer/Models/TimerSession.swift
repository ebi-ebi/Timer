//
//  TimerSession.swift
//  Timer
//
//  Created by billy on 10/5/23.
//

import Foundation

class TimerSession {
    var startTime: Date?
    var totalTime: TimeInterval
    var timeRemaining: TimeInterval
    
    var duration: TimeInterval {
        get {
            if let startTime = startTime {
                return Date().timeIntervalSince(startTime)
            }
            return 0
        }
    }
    
    init(time: TimeInterval) {
        self.totalTime = time
        self.timeRemaining = time
    }

    func resumeTimer() {
        startTime = Date()
    }
    
    func pause() {
        timeRemaining = timeRemaining - duration
        startTime = nil
    }
    
    func finished() -> Bool {
        return duration > timeRemaining
    }
    
    func paused() -> Bool {
        return startTime == nil
    }
    
    func progress() -> Double {
        return duration < timeRemaining ? duration : timeRemaining
    }
    
    func progressPrecent() -> Double {
        return progress() / totalTime
    }
    
    func displayString() -> String {
        let timeLeft = timeRemaining - progress()
        return TimerHelper.formatDisplayStringForSeconds(timeLeft > 0 ? timeLeft : 0)
    }
    
    func subSecondDisplayString() -> String {
        let timeLeft = timeRemaining - progress()
        return TimerHelper.formatDisplayStringForSubSecond(timeLeft > 0 ? timeLeft : 0)
    }
    
}

