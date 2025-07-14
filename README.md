# ⏱️ Swift Stopwatch
> A bold, energetic iOS stopwatch app with lap tracking, built with SwiftUI

<div align="center">
  
![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green.svg)
![License](https://img.shields.io/badge/License-MIT-purple.svg)

</div>

## ✨ Features

- **⏱️ Precise Timing** - Millisecond accuracy with smooth real-time updates
- **🏁 Lap Recording** - Track multiple laps with automatic best/worst identification
- **🎨 Dynamic Design** - Random vibrant background colors on each launch
- **🔤 Custom Typography** - Bold Bungee font throughout the entire app
- **💪 Motivational Start** - Inspiring quotes on splash screen to get you going
- **📱 Native iOS Feel** - Smooth gestures, haptic feedback, and fluid animations
- **🎯 Performance Optimized** - Efficient timer implementation with minimal CPU usage

## 🛠️ Architecture

### Project Structure
```
TimerApp/
├── TimerApp.swift          # App entry point
├── ContentView.swift       # Main UI and animations
├── SplashView.swift        # Motivational splash screen
├── TimerManager.swift      # Business logic and state management
├── Bungee-Regular.ttf      # Custom font file
├── Info.plist             # App configuration
└── Assets.xcassets/       # App icons and assets
```

### Key Components

#### 1. **SplashView** - The Motivator 💪
A dynamic splash screen that sets the tone for your workout or timing session:

```swift
struct SplashView: View {
    @State private var backgroundColor = ColorManager.randomColor()
    @State private var selectedQuote = QuoteManager.randomQuote()
    // ...
}
```

**Features:**
- 20 motivational quotes randomly selected
- Random vibrant background colors
- Large Bungee font typography (48pt)
- Smooth fade-in animation
- Auto-transitions to main app after 2.5 seconds

#### 2. **TimerManager** - The Brain 🧠
The `TimerManager` class handles all timing logic:

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

#### 3. **ContentView** - The Experience 🎨
The main view showcases bold design choices:

**Visual Elements:**
- **Random Background Colors**: 20 vibrant colors that change each session
- **Circular Progress Ring**: Shows seconds progress with smooth animation
- **Black Action Buttons**: High contrast buttons for better visibility
- **Custom Typography**: Bungee font for all text elements
- **Minimalist Design**: Clean white-on-color aesthetic

**Animations:**
```swift
// Button press animation
withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
    buttonScale = 0.95
}

// Lap button rotation
.rotationEffect(.degrees(lapButtonRotation))
```

## 🎨 Design System

### Color Palette
```swift
struct ColorManager {
    static let colors = [
        Color(hex: "FF6B6B"), // Red
        Color(hex: "4ECDC4"), // Teal
        Color(hex: "45B7D1"), // Blue
        Color(hex: "FFA502"), // Orange
        Color(hex: "FF6348"), // Coral
        Color(hex: "7D5FFF"), // Purple
        Color(hex: "00D2D3"), // Cyan
        // ... 13 more vibrant colors
    ]
}
```

### Typography
- **Font Family**: Bungee-Regular (custom font)
- **Header**: Bungee 18pt
- **Timer**: Bungee 42pt (reduced from 56pt for better fit)
- **Lap Time**: Bungee 18pt
- **Buttons**: Bungee 14pt
- **Splash Quotes**: Bungee 48pt

### Motivational Quotes
```swift
"TIME IS YOUR MOST VALUABLE ASSET"
"MAKE EVERY SECOND COUNT"
"DISCIPLINE BEATS MOTIVATION"
"START NOW, GET PERFECT LATER"
// ... 16 more quotes
```

## 🚀 Technical Highlights

### 1. **Dynamic Color System**
Each app launch presents a fresh, energetic color:
```swift
@State private var backgroundColor = ColorManager.randomColor()
```

### 2. **Custom Font Integration**
Bungee font loaded and applied throughout:
```swift
extension Font {
    static func bungee(size: CGFloat) -> Font {
        return Font.custom("Bungee-Regular", size: size)
    }
}
```

### 3. **Improved Timer Display**
- Smaller font size (42pt) for better readability
- Added padding inside progress circle
- High contrast white-on-color design

### 4. **Black App Icon**
- Minimalist black background
- White circular progress indicator
- Matches the app's bold aesthetic

## 📲 User Experience Flow

1. **Launch** → Motivational quote with random background color
2. **Main Screen** → Timer with vibrant random background
3. **Start** → Black play button begins timing
4. **Lap** → Black flag button records current lap
5. **View Laps** → Sheet slides up showing lap times
6. **Reset** → Clear all data and start fresh

## 🎯 Design Philosophy

### Why Random Colors?
- **Fresh Experience**: Each session feels new and energetic
- **Motivation**: Bright colors enhance mood and energy
- **Variety**: Prevents visual monotony during repeated use

### Why Bungee Font?
- **Bold & Energetic**: Matches the dynamic nature of timing activities
- **High Readability**: Clear even at small sizes
- **Personality**: Gives the app a unique, memorable character

### Why Black Buttons?
- **High Contrast**: Visible on any background color
- **Consistency**: Works with all 20 random backgrounds
- **Professional**: Clean, modern appearance

## 🔧 Building the App

1. Open `TimerApp.xcodeproj` in Xcode
2. Ensure `Bungee-Regular.ttf` is included in project
3. Select your target device/simulator
4. Press `⌘R` to build and run

### Requirements
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

## 💡 Recent Updates

- ✅ Reduced timer font size with improved padding
- ✅ Implemented random solid background colors (20 options)
- ✅ Integrated Bungee font throughout the app
- ✅ Added motivational splash screen with quotes
- ✅ Changed button backgrounds to black for contrast
- ✅ Updated app icon to black background
- ✅ Removed dark mode toggle (always uses white text)

## 🙏 Acknowledgments

This app showcases modern SwiftUI capabilities with bold design choices, custom typography, and dynamic color schemes. The Bungee font adds personality while maintaining functionality, creating an energetic timing experience.

---

<div align="center">
  
**Built with ⚡ using SwiftUI & Bungee Font**

</div>