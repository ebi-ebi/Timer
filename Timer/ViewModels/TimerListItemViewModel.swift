//
//  TimerListItemViewModel.swift
//  Timer
//
//  Created by billy on 10/16/23.
//

import Foundation

class TimerListItemViewModel: ObservableObject {
    @Published var displayString: String

    var timeDuration: TimeInterval

    convenience init() {
        self.init(timeDuration: 10)
    }
    
    init(timeDuration: TimeInterval) {
        self.timeDuration = timeDuration
        self.displayString = TimerHelper.formatDisplayStringForSeconds(timeDuration)
    }
}
