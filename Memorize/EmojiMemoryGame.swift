import SwiftUI

@Observable class EmojiMemoryGame {
    private static let colorDict = [
        "red": Color.red, "orange": Color.orange, "yellow": Color.yellow,
        "green": Color.green, "blue": Color.blue, "purple": Color.purple,
    ]
    private var game: MemoryGame<String>
    var cards: [Card] { game.cards }
    var score: Int { game.score }
    private(set) var themeName = "None"
    private(set) var themeColor = Color.black

    init() {
        self.game = MemoryGame(numberOfPairsOfCards: 0) { i in "" }
        if let theme = themes.randomElement() { createMemoryGame(withTheme: theme) }
    }

    func newGame(withTheme theme: Theme) { createMemoryGame(withTheme: theme) }

    func shuffle() { game.shuffle() }

    func choose(_ card: Card) { game.choose(card) }

    private func createMemoryGame(withTheme theme: Theme) {
        themeName = theme.name
        themeColor = EmojiMemoryGame.colorDict[theme.color] ?? Color.black

        let numPairs = min(theme.numberOfPairs, theme.emojis.count)
        let emojis = theme.emojis.shuffled().prefix(numPairs)
        game = MemoryGame(numberOfPairsOfCards: numPairs) { i in
            if emojis.indices.contains(i) { emojis[i] } else { "" }
        }
        game.shuffle()
    }
}
