import SwiftUI

struct AppIconView: View {
    let size: CGFloat
    
    var body: some View {
        ZStack {
            // Black background
            Color.black
            
            // White stopwatch circle
            Circle()
                .stroke(Color.white, lineWidth: size * 0.03)
                .frame(width: size * 0.6, height: size * 0.6)
            
            // Timer hands
            VStack(spacing: 0) {
                // Hour hand
                Rectangle()
                    .fill(Color.white)
                    .frame(width: size * 0.02, height: size * 0.2)
                    .offset(y: -size * 0.1)
                
                // Minute hand
                Rectangle()
                    .fill(Color.white)
                    .frame(width: size * 0.015, height: size * 0.25)
                    .rotationEffect(.degrees(90))
                    .offset(x: size * 0.125)
            }
            
            // Center dot
            Circle()
                .fill(Color.white)
                .frame(width: size * 0.05, height: size * 0.05)
        }
        .frame(width: size, height: size)
    }
}

// Preview for 1024x1024 App Store icon
#Preview {
    AppIconView(size: 1024)
}