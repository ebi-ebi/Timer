//
//  TimerSessionView.swift
//  Timer
//
//  Created by billy on 10/3/23.
//

import SwiftUI

struct TimerSessionView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    let timerConfig: TimerConfig?
    
    init() {
        self.timerConfig = nil
    }
    
    // Use this intializer to update timerViewModel config onAppear
    init(timerConfig: TimerConfig) {
        self.timerConfig = timerConfig
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(timerViewModel.timerEnded ? 1 : 0)
                .animation(.linear.repeatCount(timerViewModel.timerEnded ? 3 : 1), value: timerViewModel.timerEnded)
                .ignoresSafeArea()
            VStack {
                TimerCountDownText(timerViewModel: timerViewModel)
                HStack {
                    Button(action:{
                        timerViewModel.toggleTimer()
                    }) {
                        Text(timerViewModel.toggleString)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    Button(action:{
                        timerViewModel.resetTimer()
                    }) {
                        Text(timerViewModel.resetString)
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
                .padding()
            }
        }.onAppear {
            timerViewModel.shouldShowPersistingTimerInView(false)
            if let timerConfig = timerConfig {
                timerViewModel.updateTimerConfig(timerConfig: timerConfig)
                timerViewModel.startTimer()
            }
        }.onDisappear {
            timerViewModel.shouldShowPersistingTimerInView(true)
        }
    }
}

#Preview {
    TimerSessionView().environmentObject(TimerViewModel(timerConfig: TimerConfig(time: 10)))
}
