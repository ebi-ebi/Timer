//
//  TimerPersistingDisplayView.swift
//  Timer
//
//  Created by billy on 10/29/23.
//

import Foundation

import SwiftUI

struct TimerPersistingDisplayView: View {
    @ObservedObject var timerViewModel: TimerViewModel
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                TimerCountDownText(timerViewModel: timerViewModel)
                Spacer()
            }.onTapGesture {
                isPresented.toggle()
            }.sheet(isPresented: $isPresented, content: {
                TimerSessionView().environmentObject(timerViewModel)
            })
            .padding()
            .background(Color(red:0.9, green:0.9, blue:0.9, opacity:0.5))
            .cornerRadius(20)
        }
        .padding()
        .opacity(timerViewModel.showPersistingTimer ? 1 : 0)
        .animation(.linear(duration: timerViewModel.showPersistingTimer ? 1 : 0), value: timerViewModel.showPersistingTimer)
    }
}

#Preview {
    TimerPersistingDisplayView(timerViewModel: TimerViewModel(timeDuration: 10))
}
