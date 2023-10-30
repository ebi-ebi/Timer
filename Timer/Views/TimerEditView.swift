//
//  TimerEditView.swift
//  Timer
//
//  Created by billy on 10/5/23.
//

import SwiftUI

struct TimerEditView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    @State var pickedHours: Int = 0
    @State var pickedMinutes: Int = 1
    @State var pickedSeconds: Int = 0
    @State var isPresented: Bool = false
    
    func duration() -> TimeInterval {
        return (TimeInterval)(self.pickedHours * 3600 + self.pickedMinutes * 60 + self.pickedSeconds)
    }
    
    func makeValid() {
        if duration() == 0 {
            pickedMinutes = 1
        }
    }
    
    func timerSessionView() -> some View {
        return TimerSessionView(timerConfig: TimerConfig(time:duration()))
            .environmentObject(timerViewModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Picker("Select Hours", selection: $pickedHours) {
                    ForEach (0 ... 23, id: \.self) {
                        Text("\($0)")
                            .font(Font.custom("DigitaldreamNarrow", size: 20, relativeTo: .title3))
                    }
                }
                .onChange(of: pickedHours) { value in
                    makeValid()
                }
                .pickerStyle(.wheel)
                Text(":")
                    .font(Font.custom("DigitaldreamNarrow", size: 20, relativeTo: .title3))

                Picker("Select Minutes", selection: $pickedMinutes) {
                    ForEach (0 ... 59, id: \.self) {
                        Text(String(format: "%02.0f", (Double)($0)))
                            .font(Font.custom("DigitaldreamNarrow", size: 20, relativeTo: .title3))

                    }
                }
                .onChange(of: pickedMinutes) { value in
                    makeValid()
                }
                .pickerStyle(.wheel)
                .animation(.linear, value: pickedMinutes)
                Text(":")
                    .font(Font.custom("DigitaldreamNarrow", size: 20, relativeTo: .title3))
                Picker("Select Seconds", selection: $pickedSeconds) {
                    ForEach (0 ... 59, id: \.self) {
                        Text(String(format: "%02.0f", (Double)($0)))
                            .font(Font.custom("DigitaldreamNarrow", size: 20, relativeTo: .title3))

                    }
                }
                .onChange(of: pickedSeconds) { value in
                    makeValid()
                }
                .pickerStyle(.wheel)
                Spacer()
                Button(action: { isPresented.toggle() }, label: {
                    Text("Start")
                })
                    .sheet(isPresented: $isPresented, content: { timerSessionView() })
                    .padding()
            }
        }.onAppear {
            timerViewModel.shouldShowPersistingTimerInView(true)
        }
    }
}

#Preview {
    TimerEditView()
        .environmentObject(TimerViewModel())
}
