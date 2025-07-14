# 🏃‍♂️ Swift Stopwatch
> A beautifully crafted iOS stopwatch app with lap tracking, built with SwiftUI

<div align="center">
  
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green.svg)
![License](https://img.shields.io/badge/License-MIT-purple.svg)

</div>

## ✨ Features

- **⏱️ Precise Timing** - Millisecond accuracy with smooth real-time updates
- **🏁 Lap Recording** - Track multiple laps with automatic best/worst identification
- **🎨 Modern Design** - Beautiful gradients, animations, and dark theme
- **📱 Native iOS Feel** - Smooth gestures, haptic feedback, and fluid animations
- **🎯 Performance Optimized** - Efficient timer implementation with minimal CPU usage

## 🛠️ Architecture

### Project Structure
```
TimerApp/
├── TimerApp.swift          # App entry point
├── ContentView.swift       # Main UI and animations
├── TimerManager.swift      # Business logic and state management
├── BottomSheet.swift       # Reusable bottom sheet component
├── Info.plist             # App configuration
└── Assets.xcassets/       # App icons and colors
```

### Key Components

#### 1. **TimerManager** - The Brain 🧠
The `TimerManager` class is an `ObservableObject` that handles all timing logic:

```swift
class TimerManager: ObservableObject {
    @Published var timeElapsed: TimeInterval = 0
    @Published var isRunning = false
    @Published var laps: [Lap] = []
    // ...
}
```

**Key Features:**
- Uses `Timer.scheduledTimer` for precise timing
- Publishes state changes for reactive UI updates
- Tracks both total time and individual lap times
- Automatically identifies fastest and slowest laps

#### 2. **ContentView** - The Beauty 💅
The main view showcases modern SwiftUI design patterns:

**Visual Elements:**
- **Circular Progress Ring**: Shows seconds progress with smooth animation
- **Gradient Buttons**: Three distinct gradient styles for visual hierarchy
- **Dark Theme**: Easy on the eyes with `#0f0c29` background
- **Typography**: Mix of thin, light, and medium weights for visual balance

**Animations:**
```swift
// Button press animation
withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
    buttonScale = 0.95
}

// Lap button rotation
.rotationEffect(.degrees(lapButtonRotation))
```

#### 3. **BottomSheet** - The Experience 📱
A custom bottom sheet implementation with:
- **Drag to dismiss** gesture
- **Background blur** using `UIVisualEffectView`
- **Elastic animations** for natural feel
- **Tap outside to close** functionality

```swift
struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    @State private var dragOffset: CGFloat = 0
    // ...
}
```

## 🎨 Design System

### Color Palette
```swift
// Primary Gradient - Purple Dream
LinearGradient(
    colors: [Color(hex: "667eea"), Color(hex: "764ba2")],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

// Secondary Gradient - Sunset Blush
LinearGradient(
    colors: [Color(hex: "f093fb"), Color(hex: "f5576c")],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)

// Accent Gradient - Ocean Breeze
LinearGradient(
    colors: [Color(hex: "4facfe"), Color(hex: "00f2fe")],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
)
```

### Typography Scale
- **Header**: System 18pt, Light, 5pt tracking
- **Timer**: System 56pt, Thin, Monospaced
- **Lap Time**: System 24pt, Light, Monospaced
- **Buttons**: System 16pt, Medium

## 🚀 Technical Highlights

### 1. **Reactive State Management**
Using Combine framework through `@Published` properties ensures UI updates automatically when state changes:

```swift
@Published var timeElapsed: TimeInterval = 0
// UI automatically updates when timeElapsed changes
```

### 2. **Performance Optimization**
- Timer updates every 10ms (100Hz) for smooth display
- Efficient lap array management with `insert(at: 0)`
- Minimal view re-renders using targeted `@State` properties

### 3. **Native iOS Integration**
- **SF Symbols** for consistent iconography
- **UIKit Integration** for blur effects
- **SwiftUI Animations** for fluid interactions

### 4. **Custom Extensions**
```swift
extension Color {
    init(hex: String) {
        // Converts hex strings to SwiftUI Colors
    }
}
```

## 📲 User Experience Flow

1. **Start** → Play button begins timing with spring animation
2. **Lap** → Flag button records current lap (with 360° rotation)
3. **View Laps** → Bottom sheet slides up with blur background
4. **Stop** → Pause button halts timing
5. **Reset** → Clockwise arrow clears all data

## 🎯 Design Decisions

### Why These Colors?
- **Purple/Pink**: Energy and movement, perfect for active timing
- **Blue**: Trust and precision, ideal for lap recording
- **Dark Background**: Reduces eye strain during extended use

### Why Bottom Sheet?
- **Familiar iOS Pattern**: Users expect this interaction
- **Space Efficiency**: Keeps main timer always visible
- **Natural Gesture**: Swipe down to dismiss feels intuitive

### Why These Animations?
- **Spring Physics**: Feels natural and responsive
- **Rotation on Lap**: Provides visual feedback for action
- **Scale on Press**: Standard iOS button behavior

## 🔧 Building the App

1. Open `TimerApp.xcodeproj` in Xcode
2. Select your target device/simulator
3. Press `⌘R` to build and run

### Requirements
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

## 💡 Future Enhancements

- [ ] Haptic feedback on button presses
- [ ] Sound effects for lap recording
- [ ] Export lap times to CSV
- [ ] Apple Watch companion app
- [ ] Widget for quick access
- [ ] Multiple timer support

## 🙏 Acknowledgments

This app showcases the power of SwiftUI in creating beautiful, performant iOS applications with minimal code. The design philosophy follows Apple's Human Interface Guidelines while adding unique personality through colors and animations.

---

<div align="center">
  
**Built with ❤️ using SwiftUI**

</div>