//
//  TimerListView.swift
//  Timer
//
//  Created by billy on 10/3/23.
//

import SwiftUI

struct TimerListView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    @State var pickedTimeInterval: TimeInterval = 5
    @State var isPresented: Bool = false

    func timerSessionView() -> some View {
        return TimerSessionView(timerConfig: TimerConfig(time:pickedTimeInterval))
            .environmentObject(timerViewModel)
    }

    var body: some View {
        HStack {
            Picker("Option", selection: $pickedTimeInterval) {
                ForEach (TimerHelper.getQuickTimeOptions(), id: \.self) {
                    TimerListItemView(viewModel: TimerListItemViewModel(timerConfig: TimerConfig(time:$0))).padding()
                }
            }
            .pickerStyle(.wheel)
            Button(action: { isPresented.toggle() }, label: {
                Text("Start")
            })
                .sheet(isPresented: $isPresented, content: { timerSessionView() })
                .padding()
        }.onAppear {
            pickedTimeInterval = 60
            timerViewModel.shouldShowPersistingTimerInView(true)
        }
    }
}

#Preview {
    TimerListView()
        .environmentObject(TimerViewModel())
}
