import SwiftUI

typealias Card = MemoryGame<String>.Card

struct CardView: View {
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor: CGFloat = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }

    private let card: Card
    private let color: Color

    var body: some View {
        Pie(endAngle: .degrees(240))
            .fill(color)
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp, color: color)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }

    init(_ card: Card, withColor color: Color) {
        self.card = card
        self.color = color
    }
}

#Preview {
    HStack {
        CardView(Card(id: "test1", content: "X"), withColor: .green)
        CardView(Card(id: "test1", isFaceUp: true, content: "X"), withColor: .green)
    }.padding()
}
