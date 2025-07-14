import Foundation
import Combine

struct Lap: Identifiable {
    let id = UUID()
    let lapNumber: Int
    let lapTime: TimeInterval
    let totalTime: TimeInterval
    let timestamp: Date
}

class TimerManager: ObservableObject {
    @Published var timeElapsed: TimeInterval = 0
    @Published var isRunning = false
    @Published var laps: [Lap] = []
    @Published var lastLapTime: TimeInterval = 0
    
    private var timer: Timer?
    private var startTime: Date?
    private var lapStartTime: TimeInterval = 0
    
    var timeString: String {
        formatTime(timeElapsed)
    }
    
    var lapTimeString: String {
        formatTime(timeElapsed - lapStartTime)
    }
    
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    func start() {
        startTime = Date()
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            if let startTime = self.startTime {
                self.timeElapsed = Date().timeIntervalSince(startTime)
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func reset() {
        stop()
        timeElapsed = 0
        laps = []
        lapStartTime = 0
        lastLapTime = 0
    }
    
    func recordLap() {
        let lapTime = timeElapsed - lapStartTime
        let lap = Lap(
            lapNumber: laps.count + 1,
            lapTime: lapTime,
            totalTime: timeElapsed,
            timestamp: Date()
        )
        laps.insert(lap, at: 0)
        lapStartTime = timeElapsed
        lastLapTime = lapTime
    }
    
    var fastestLap: Lap? {
        laps.min(by: { $0.lapTime < $1.lapTime })
    }
    
    var slowestLap: Lap? {
        laps.max(by: { $0.lapTime < $1.lapTime })
    }
}