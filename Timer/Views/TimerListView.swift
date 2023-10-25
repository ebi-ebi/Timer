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
        List(TimerHelper.getQuickTimeOptions(), id: \.self) { timerConfig in
            NavigationLink {
                TimerSessionView(timerConfig: timerConfig)
            } label: {
                TimerListItemView(viewModel: TimerListItemViewModel(timerConfig: timerConfig))
            }
        }.frame(maxHeight: 300)
    }
}

#Preview {
    TimerListView()
}
