//
//  TimerListView.swift
//  Timer
//
//  Created by billy on 10/3/23.
//

import SwiftUI

struct TimerListView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    func timerSessionView(timerConfig: TimerConfig) -> some View {
        return TimerSessionView(timerConfig: timerConfig)
            .environmentObject(timerViewModel)
    }

    var body: some View {
        List(TimerHelper.getQuickTimeOptions(), id: \.self) { timerConfig in
            NavigationLink {
                timerSessionView(timerConfig: timerConfig)
            } label: {
                TimerListItemView(viewModel: TimerListItemViewModel(timerConfig: timerConfig))
            }
        }
    }
}

#Preview {
    TimerListView()
        .environmentObject(TimerViewModel())
}
