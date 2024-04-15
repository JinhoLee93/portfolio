//
//  BackgroundClock.swift
//  FortySeconds
//
//  Created by Jinho Lee on 2/20/22.
//

import Foundation
import Combine
import SwiftUI

class BackgroundClock: ObservableObject {
    @Published private(set) var message = "Not Running"
    @Published private(set) var isRunning = false
    
    private var startTime: Date? { didSet { saveStartTime() } }
    private var timer: AnyCancellable?
    
    init() {
        startTime = fetchStartTime()
        start()
    }
}

extension BackgroundClock {
    func start() {
        let time: Double = 86400
        timer?.cancel()
        
        if startTime == nil {
            startTime = Date()
        }
        
        
        message = ""
        timer = Timer
            .publish(every: 1, on: RunLoop.main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self, let startTime = self.startTime else { return }
                 
                let elapsed = Date().timeIntervalSince(startTime)
                
                guard elapsed < time else {
                    self.isRunning = false
                    return
                }

                let timeLeft = Int(time - elapsed)
                let hours = timeLeft / 3600
                let mins = (timeLeft % 3600) / 60
                let secs = (timeLeft % 3600) % 60
                
                self.message = BackgroundClock.timeConverter(hours, mins, secs)
            }
        
        isRunning = true
    }
    
    static func timeConverter(_ hours: Int, _ mins: Int, _ secs: Int) -> String {
        let newHours = hours < 10 ? "0\(hours)" : "\(hours)"
        let newMins = mins < 10 ? "0\(mins)" : "\(mins)"
        let newSecs = secs < 10 ? "0\(secs)" : "\(secs)"
        
        return "\(newHours):\(newMins):\(newSecs)"
    }
    
    func stop() {
        timer?.cancel()
        timer = nil
        startTime = nil
        isRunning = false
    }
}

private extension BackgroundClock {
    func saveStartTime() {
        if let startTime = startTime {
            UserDefaults.standard.set(startTime, forKey: "startTime")
        } else {
            UserDefaults.standard.removeObject(forKey: "startTime")
        }
    }
    
    func fetchStartTime() -> Date? {
        UserDefaults.standard.object(forKey: "startTime") as? Date
    }
}
