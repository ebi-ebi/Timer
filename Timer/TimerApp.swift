//
//  TimerApp.swift
//  Timer
//
//  Created by billy on 9/28/23.
//

import SwiftUI

@main
struct TimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    TimerNotificationManager.currentManager().requestForAuthorization()
                }
        }
    }
}
