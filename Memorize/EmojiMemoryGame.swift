import SwiftUI

@Observable class EmojiMemoryGame {
    private static let colorDict = [
        "red": Color.red, "orange": Color.orange, "yellow": Color.yellow,
        "green": Color.green, "blue": Color.blue, "purple": Color.purple,
    ]
    var cards: [MemoryGame<String>.Card] { game.cards }
    var themeName = "None"
    var themeColor = Color.black
    var score = 0
    private var game: MemoryGame<String>

    init() {
        self.game = MemoryGame(numberOfPairsOfCards: 0) { i in "" }
        if let theme = themes.randomElement() {
            createMemoryGame(withTheme: theme)
        }
    }

    func newGame(withTheme theme: Theme) {
        createMemoryGame(withTheme: theme)
    }

    func shuffle() {
        game.shuffle()
    }

    func choose(_ card: MemoryGame<String>.Card) {
        game.choose(card)
    }

    private func createMemoryGame(withTheme theme: Theme) {
        themeName = theme.name
        themeColor = EmojiMemoryGame.colorDict[theme.color] ?? Color.black
        let emojis = theme.emojis.shuffled().prefix(theme.numberOfPairs)
        game = MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) {
            i in
            if emojis.indices.contains(i) {
                emojis[i]
            } else {
                ""
            }
        }
        game.shuffle()
    }
}
