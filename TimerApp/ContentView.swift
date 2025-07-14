import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject private var timerManager = TimerManager()
    @State private var showLaps = false
    @State private var buttonScale: CGFloat = 1.0
    @State private var lapButtonRotation: Double = 0
    @State private var backgroundColor = ColorManager.randomColor()
    
    let primaryGradient = LinearGradient(
        colors: [Color.black, Color.black],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    let secondaryGradient = LinearGradient(
        colors: [Color.black, Color.black],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    let accentGradient = LinearGradient(
        colors: [Color.black, Color.black],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    
    var textColor: Color {
        .white
    }
    
    let hapticManager = HapticManager()
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
                .overlay(
                    Color.black.opacity(showLaps ? 0.4 : 0)
                        .ignoresSafeArea()
                        .animation(.easeInOut(duration: 0.3), value: showLaps)
                )
            
            VStack(spacing: 40) {
                    Text("STOPWATCH")
                        .font(.bungee(size: 18))
                        .foregroundColor(textColor.opacity(0.9))
                        .tracking(5)
                        .padding(.top, 10)
                    
                    ZStack {
                        Circle()
                            .stroke(textColor.opacity(0.1), lineWidth: 8)
                            .frame(width: 280, height: 280)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(timerManager.timeElapsed.truncatingRemainder(dividingBy: 60)) / 60)
                            .stroke(primaryGradient, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                            .frame(width: 280, height: 280)
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 0.01), value: timerManager.timeElapsed)
                        
                        VStack(spacing: 10) {
                            Text(timerManager.timeString)
                                .font(.bungee(size: 42))
                                .foregroundColor(textColor)
                                .padding(.horizontal, 20)
                            
                            if timerManager.isRunning || timerManager.laps.count > 0 {
                                Text("LAP \(timerManager.laps.count + 1)")
                                    .font(.bungee(size: 12))
                                    .foregroundColor(textColor.opacity(0.6))
                                
                                Text(timerManager.lapTimeString)
                                    .font(.bungee(size: 18))
                                    .foregroundColor(.white)
                                    .animation(.spring(), value: timerManager.laps.count)
                            }
                        }
                        .padding(20)
                    }
                    .padding(.vertical, 30)
                    
                    HStack(spacing: 50) {
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                if timerManager.isRunning {
                                    timerManager.stop()
                                    hapticManager.notification(type: .warning)
                                } else {
                                    timerManager.start()
                                    hapticManager.notification(type: .success)
                                }
                                buttonScale = 0.95
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    buttonScale = 1.0
                                }
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(timerManager.isRunning ? secondaryGradient : primaryGradient)
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: timerManager.isRunning ? "pause.fill" : "play.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                    .offset(x: timerManager.isRunning ? 0 : 3)
                            }
                            .scaleEffect(buttonScale)
                            .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 10)
                        }
                        
                        Button(action: {
                            if timerManager.isRunning {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    timerManager.recordLap()
                                    lapButtonRotation += 360
                                }
                                hapticManager.impact(style: .medium)
                            } else {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    timerManager.reset()
                                }
                                hapticManager.impact(style: .light)
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(timerManager.isRunning ? Color.black : Color.white.opacity(0.2))
                                    .frame(width: 60, height: 60)
                                
                                Image(systemName: timerManager.isRunning ? "flag.fill" : "arrow.clockwise")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(timerManager.isRunning ? lapButtonRotation : 0))
                            }
                            .shadow(color: Color.black.opacity(0.2), radius: 15, x: 0, y: 8)
                        }
                    }
                    .padding(.bottom, 40)
                    
                    if timerManager.laps.count > 0 {
                        Button(action: {
                            showLaps = true
                            hapticManager.impact(style: .light)
                        }) {
                            HStack {
                                Text("View Laps")
                                    .font(.bungee(size: 14))
                                
                                Text("(\(timerManager.laps.count))")
                                    .font(.bungee(size: 12))
                                    .opacity(0.8)
                                
                                Image(systemName: "chevron.up")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.white.opacity(0.2))
                            .clipShape(Capsule())
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                Spacer()
            }
            .padding(.top, 60)
            .blur(radius: showLaps ? 5 : 0)
            .animation(.easeInOut(duration: 0.3), value: showLaps)
        }
        .sheet(isPresented: $showLaps) {
            LapsView(laps: timerManager.laps, timerManager: timerManager)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
                .presentationBackground(.regularMaterial)
                .onAppear {
                    hapticManager.impact(style: .rigid)
                }
        }
    }
}

struct LapsView: View {
    let laps: [Lap]
    let timerManager: TimerManager
    @Environment(\.dismiss) private var dismiss
    let hapticManager = HapticManager()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(laps) { lap in
                            HStack {
                                Text("LAP \(lap.lapNumber)")
                                    .font(.bungee(size: 12))
                                    .foregroundColor(.secondary)
                                    .frame(width: 80, alignment: .leading)
                                
                                Text(timerManager.formatTime(lap.lapTime))
                                    .font(.bungee(size: 16))
                                    .foregroundColor(
                                        lap.id == timerManager.fastestLap?.id ? Color(hex: "4facfe") :
                                        lap.id == timerManager.slowestLap?.id ? Color(hex: "f5576c") :
                                        .primary
                                    )
                                
                                Spacer()
                                
                                if lap.id == timerManager.fastestLap?.id {
                                    Label("Fastest", systemImage: "hare.fill")
                                        .font(.bungee(size: 10))
                                        .foregroundColor(Color(hex: "4facfe"))
                                } else if lap.id == timerManager.slowestLap?.id {
                                    Label("Slowest", systemImage: "tortoise.fill")
                                        .font(.bungee(size: 10))
                                        .foregroundColor(Color(hex: "f5576c"))
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Lap Times")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        hapticManager.impact(style: .light)
                        dismiss()
                    }
                    .font(.bungee(size: 14))
                }
            }
        }
    }
}

class HapticManager {
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ColorManager {
    static let colors = [
        Color(hex: "FF6B6B"), // Red
        Color(hex: "4ECDC4"), // Teal
        Color(hex: "45B7D1"), // Blue
        Color(hex: "FFA502"), // Orange
        Color(hex: "FF6348"), // Coral
        Color(hex: "7D5FFF"), // Purple
        Color(hex: "00D2D3"), // Cyan
        Color(hex: "FF4757"), // Pink Red
        Color(hex: "5F27CD"), // Deep Purple
        Color(hex: "00A8FF"), // Sky Blue
        Color(hex: "FFC048"), // Yellow
        Color(hex: "54A0FF"), // Light Blue
        Color(hex: "48DBFB"), // Light Cyan
        Color(hex: "FF9FF3"), // Pink
        Color(hex: "FECA57"), // Amber
        Color(hex: "EE5A24"), // Dark Orange
        Color(hex: "10AC84"), // Green
        Color(hex: "C44569"), // Rose
        Color(hex: "3C40C6"), // Indigo
        Color(hex: "F8B500")  // Gold
    ]
    
    static func randomColor() -> Color {
        colors.randomElement() ?? Color(hex: "667eea")
    }
}

extension Font {
    static func bungee(size: CGFloat) -> Font {
        return Font.custom("Bungee-Regular", size: size)
    }
}

#Preview {
    ContentView()
}