//
//  TimerEditView.swift
//  Timer
//
//  Created by billy on 10/5/23.
//

import SwiftUI

struct TimerEditView: View {
    @State var pickedHours: Int = 0
    @State var pickedMinutes: Int = 1
    @State var pickedSeconds: Int = 0
    
    func duration() -> TimeInterval {
        return (TimeInterval)(self.pickedHours * 3600 + self.pickedMinutes * 60 + self.pickedSeconds)
    }
    
    func makeValid() {
        if duration() == 0 {
            pickedMinutes = 1
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Picker("Select Hours", selection: $pickedHours) {
                    ForEach (0 ... 23, id: \.self) {
                        Text("\($0)")
                    }
                }
                .onChange(of: pickedHours) { value in
                    makeValid()
                }
                .pickerStyle(.wheel)
                Text(":")
                Picker("Select Minutes", selection: $pickedMinutes) {
                    ForEach (0 ... 59, id: \.self) {
                        Text(String(format: "%02.0f", (Double)($0)))
                    }
                }
                .onChange(of: pickedMinutes) { value in
                    makeValid()
                }
                .pickerStyle(.wheel)
                .animation(.linear, value: pickedMinutes)
                Text(":")
                Picker("Select Seconds", selection: $pickedSeconds) {
                    ForEach (0 ... 59, id: \.self) {
                        Text(String(format: "%02.0f", (Double)($0)))
                    }
                }
                .onChange(of: pickedSeconds) { value in
                    makeValid()
                }
                .pickerStyle(.wheel)
            }
            NavigationLink(destination: TimerSessionView(timerConfig: TimerConfig(time: self.duration()))
            ) {
                Text("Go")
            }
        }
    }
}

struct TimerEditView_Previews: PreviewProvider {
    static var previews: some View {
        TimerEditView()
    }
}
