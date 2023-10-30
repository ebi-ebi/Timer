//
//  ContentView.swift
//  Timer
//
//  Created by billy on 9/28/23.
//

import SwiftUI

struct ContentView: View {
    // Persistent timer view model
    @StateObject var timerViewModel: TimerViewModel = TimerViewModel()

    var body: some View {
        ZStack {
            NavigationView {
                TimerListView()
                    .environmentObject(timerViewModel)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Text("Timer")
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink (destination: TimerEditView().environmentObject(timerViewModel)) {
                                Text("+")
                            }
                        }
                    }
            }.ignoresSafeArea()
            TimerPersistingDisplayView(timerViewModel: timerViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}
