//
//  TimerListView.swift
//  Timer
//
//  Created by billy on 10/3/23.
//

import SwiftUI

struct TimerListView: View {
    let timerConfigs = [
        TimerConfig(time: 60),
        TimerConfig(time: 120),
        TimerConfig(time: 180),
        TimerConfig(time: 300),
        TimerConfig(time: 600),
        TimerConfig(time: 900),
        TimerConfig(time: 1800),
        TimerConfig(time: 2700),
        TimerConfig(time: 3600)
    ]
    
    var body: some View {
        List(timerConfigs, id: \.self) { timerConfig in
            NavigationLink {
                TimerSessionView(timerConfig: timerConfig)
            } label: {
                TimerCountDownText(viewModel: TimerViewModel(timerConfig: timerConfig))
            }
        }
    }
}

struct TimerListView_Previews: PreviewProvider {
    static var previews: some View {
        TimerListView()
    }
}
