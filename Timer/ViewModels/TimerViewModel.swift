//
//  TimerViewModel.swift
//  Timer
//
//  Created by billy on 10/5/23.
//

import AudioToolbox
import Foundation

class TimerViewModel: ObservableObject {
    @Published var displayString: String = ""
    @Published var subSecondDisplayString: String = ""
    @Published var toggleString: String = "Start"
    @Published var stopString: String = "Stop"
    @Published var resetString: String = "Reset"
    // This flips only when the timer ends
    @Published var timerEnded: Bool = false
    // When a TimerSession exist and view stack decides to show persisting timer
    @Published var showPersistingTimer: Bool = false
    
    var showPersistingTimerInView: Bool = false
    var timerConfig: TimerConfig?
    var timerSession: TimerSession?
    var updateTimer: Timer? = nil
    
    init() {
        self.timerConfig = TimerConfig(time: 1)
    }
    
    init(timerConfig: TimerConfig) {
        self.timerConfig = timerConfig
        self.update()
    }
    
    func updateTimerConfig(timerConfig: TimerConfig) {
        self.resetTimer()
        self.timerConfig = timerConfig
        self.update()
    }
    
    private func startUpdate() {
        // Start update timer
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.update()
        }
    }
    
    private func stopUpdate() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    private func update() {
        guard let timerConfig = timerConfig else {
            return
        }
        if let timerSession = timerSession {
            displayString = timerSession.displayString()
            subSecondDisplayString = timerSession.subSecondDisplayString()
            if timerSession.finished() {
                AudioServicesPlaySystemSound(SystemSoundID(1033))
                timerEnded = true
                stopUpdate()
            }
        } else {
            displayString = TimerHelper.formatDisplayStringForSeconds(timerConfig.time)
            subSecondDisplayString = ""
            toggleString = "Start"
        }
    }
    
    private func setupNotification(after time: TimeInterval) {
        TimerNotificationManager.currentManager().sendNotification(title: "Timer complete", body: "", duration: time)
    }

    // Persistent Timer View
    func shouldShowPersistingTimerInView(_ showInView: Bool) {
        showPersistingTimerInView = showInView
        updateShowPersistingTimer()
    }
    
    private func updateShowPersistingTimer() {
        showPersistingTimer = showPersistingTimerInView && timerSession != nil
    }
    
    // Timer functions
    
    // Start / Pause / Resume Timer
    func toggleTimer() {
        if let timerSession = timerSession {
            if timerSession.paused() {
                resumeTimer()
                toggleString = "Pause"
            } else {
                pauseTimer()
                toggleString = "Resume"
            }
        } else {
            startTimer()
        }
    }
    
    func startTimer() {
        guard let timerConfig = timerConfig else {
            return
        }

        let timerSession = TimerSession(time: timerConfig.time)
        timerSession.resumeTimer()
        self.timerSession = timerSession

        updateShowPersistingTimer()
        
        setupNotification(after: timerSession.timeRemaining)

        toggleString = "Pause"

        startUpdate()
    }
    
    func pauseTimer() {
        timerSession?.pause()

        stopUpdate()
        
        TimerNotificationManager.currentManager().cancelNotification()
    }

    func resumeTimer() {
        if let timerSession = timerSession {
            timerSession.resumeTimer()
            
            setupNotification(after: timerSession.timeRemaining)

            startUpdate()
        }
    }
    
    func resetTimer() {
        timerSession = nil
        timerEnded = false
        
        stopUpdate()

        updateShowPersistingTimer()

        TimerNotificationManager.currentManager().cancelNotification()

        update()
    }
}

