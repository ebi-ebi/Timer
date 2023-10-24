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
    
    var timerConfig: TimerConfig
    var timerSession: TimerSession?
    var updateTimer: Timer? = nil
    
    convenience init() {
        self.init(timerConfig: TimerConfig(time: 10))
    }
    
    init(timerConfig: TimerConfig) {
        self.timerConfig = timerConfig
        self.update()
    }
    
    func updateTimerConfig(timerConfig: TimerConfig) {
        self.timerConfig = timerConfig
        self.update()
    }
    
    func startUpdate() {
        // Start update timer
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] _ in
            self?.update()
        }
    }
    
    func stopUpdate() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    func update() {
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
        let timerSession = TimerSession(time: timerConfig.time)
        timerSession.resumeTimer()
        self.timerSession = timerSession

        setupNotification(after: timerSession.timeRemaining)

        toggleString = "Pause"

        startUpdate()
    }
    
    func resetTimer() {
        timerSession = nil
        timerEnded = false
        
        stopUpdate()
        update()
    }

    // TODO

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
    
    func setupNotification(after time: TimeInterval) {
        TimerNotificationManager.currentManager().sendNotification(title: "Timer complete", body: "", duration: time)
    }
}

