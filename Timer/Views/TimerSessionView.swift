//
//  TimerSessionView.swift
//  Timer
//
//  Created by billy on 10/3/23.
//

import SwiftUI

struct TimerSessionView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    let timeDuration: TimeInterval?
    
    init() {
        self.timeDuration = nil
    }
    
    // Use this intializer to update timerViewModel config onAppear
    init(timeDuration: TimeInterval) {
        self.timeDuration = timeDuration
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("TimerSessionBackground1"), Color("TimerSessionBackground2")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            LinearGradient(gradient: Gradient(colors: [Color("TimerSessionBackground2"), Color("TimerSessionBackground1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
            if let timeDuration = timeDuration {
                timerViewModel.updateTimeDuration(timeDuration: timeDuration)
                timerViewModel.startTimer()
            }
        }.onDisappear {
            timerViewModel.shouldShowPersistingTimerInView(true)
        }
    }
}

#Preview {
    TimerSessionView().environmentObject(TimerViewModel(timeDuration: 10))
}
