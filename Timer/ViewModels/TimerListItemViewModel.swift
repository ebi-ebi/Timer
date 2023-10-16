//
//  TimerListItemViewModel.swift
//  Timer
//
//  Created by billy on 10/16/23.
//

import Foundation

class TimerListItemViewModel: ObservableObject {
    @Published var displayString: String

    var timerConfig: TimerConfig

    convenience init() {
        self.init(timerConfig: TimerConfig(time: 10))
    }
    
    init(timerConfig: TimerConfig) {
        self.timerConfig = timerConfig
        self.displayString = TimerHelper.formatDisplayStringForSeconds(timerConfig.time)
    }
}
