import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    let color: Color

    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.strokeBorder(lineWidth: Constants.lineWidth)
                .background(base.fill(.white))
                .overlay(content)	
                .opacity(isFaceUp ? 1 : 0)
            base.fill(.linearGradient(colors: [.white, color], startPoint: .topLeading, endPoint: .bottomTrailing))
                .opacity(isFaceUp ? 0 : 1)
        }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFaceUp: Bool, color: Color) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
