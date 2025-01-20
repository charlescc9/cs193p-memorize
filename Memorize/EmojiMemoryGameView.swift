import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2 / 3
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card, withColor: viewModel.themeColor)
                .padding(2)
                .onTapGesture { viewModel.choose(card) }
        }
    }

    var body: some View {
        VStack {
            Text("Memorize").font(.title)
            cards
                .animation(.default, value: viewModel.cards)
            HStack {
                Text("Theme: \(viewModel.themeName)").bold()
                Spacer()
                Text("Score: \(viewModel.score)").bold()
                Spacer()
                Button("New Game") {
                    if let newTheme = themes.randomElement() {
                        viewModel.newGame(withTheme: newTheme)
                    }
                }.bold()
            }
        }
        .padding()
    }
}

struct CardView: View {
    private let card: MemoryGame<String>.Card
    private let color: Color

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill(
                LinearGradient(
                    colors: [.white, color], startPoint: .topLeading, endPoint: .bottomTrailing)
            ).opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }

    init(_ card: MemoryGame<String>.Card, withColor color: Color) {
        self.card = card
        self.color = color
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
