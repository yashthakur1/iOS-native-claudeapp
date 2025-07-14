import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var backgroundColor = ColorManager.randomColor()
    @State private var selectedQuote = QuoteManager.randomQuote()
    @State private var opacity: Double = 0
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                
                VStack {
                    Text(selectedQuote)
                        .font(.bungee(size: 48))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 50)
                        .opacity(opacity)
                        .minimumScaleFactor(0.7)
                        .lineSpacing(10)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .onAppear {
                withAnimation(.easeIn(duration: 0.8)) {
                    self.opacity = 1.0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct QuoteManager {
    static let quotes = [
        "TIME IS YOUR MOST VALUABLE ASSET",
        "MAKE EVERY SECOND COUNT",
        "DISCIPLINE BEATS MOTIVATION",
        "START NOW, GET PERFECT LATER",
        "PROGRESS OVER PERFECTION",
        "CONSISTENCY IS KEY",
        "SMALL STEPS, BIG RESULTS",
        "FOCUS ON WHAT MATTERS",
        "BE BETTER THAN YESTERDAY",
        "YOUR ONLY LIMIT IS YOU",
        "HUSTLE IN SILENCE",
        "WORK HARD IN SILENCE",
        "STAY HUNGRY, STAY FOOLISH",
        "DONE IS BETTER THAN PERFECT",
        "EMBRACE THE GRIND",
        "CHAMPIONS TRAIN, LOSERS COMPLAIN",
        "NO EXCUSES, JUST RESULTS",
        "DREAM BIG, WORK HARD",
        "SUCCESS DEMANDS SACRIFICE",
        "TURN OBSTACLES INTO OPPORTUNITIES"
    ]
    
    static func randomQuote() -> String {
        quotes.randomElement() ?? "MAKE EVERY SECOND COUNT"
    }
}

#Preview {
    SplashView()
}