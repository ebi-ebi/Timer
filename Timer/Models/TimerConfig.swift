//
//  Timer.swift
//  Timer
//
//  Created by billy on 9/28/23.
//

import Foundation

class TimerConfig: NSObject, NSCoding, Identifiable {
    static func == (lhs: TimerConfig, rhs: TimerConfig) -> Bool {
        return lhs.time == rhs.time
    }
    
    static func dummy() -> TimerConfig {
        return TimerConfig(time: 10)
    }
    
    var time: TimeInterval // In seconds
    
    required init?(coder: NSCoder) {
        time = coder.decodeDouble(forKey: "time")
    }
    
    init(time: Double) {
        self.time = time
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(time, forKey: "time")
    }
}
