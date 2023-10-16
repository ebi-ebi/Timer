//
//  TimerSessionView.swift
//  Timer
//
//  Created by billy on 10/3/23.
//

import SwiftUI

struct TimerSessionView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    init() {
        self.init(timerConfig: TimerConfig(time: 10))
    }
    
    init(timerConfig: TimerConfig) {
        viewModel = TimerViewModel(timerConfig: timerConfig)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .opacity(viewModel.timerEnded ? 1 : 0)
                .animation(.linear.repeatCount(viewModel.timerEnded ? 3 : 1), value: viewModel.timerEnded)
                .ignoresSafeArea()
            VStack {
                TimerCountDownText(viewModel: viewModel)
                HStack {
                    Button(action:{
                        viewModel.toggleTimer()
                    }) {
                        Text(viewModel.toggleString)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                    Button(action:{
                        viewModel.resetTimer()
                    }) {
                        Text(viewModel.resetString)
                    }
                    .buttonStyle(.bordered)
                    .padding()
                }
                .padding()
            }
        }
    }
}

#Preview {
    TimerSessionView()
}
