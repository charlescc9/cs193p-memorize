import SwiftUI

struct EmojiMemoryGameView: View {
    var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2 / 3
    private let spacing: CGFloat = 4
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card, withColor: viewModel.themeColor)
                .padding(spacing)
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

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
