import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}

struct Theme {
    let name: String
    let emojis: [String]
    let numberOfPairs: Int
    let color: String
}

let themes: [Theme] = [
    Theme(
        name: "Flags", emojis: ["🇰🇷", "🇦🇽", "🇧🇪", "🇨🇦", "🇲🇾", "🇬🇪", "🇧🇷", "🇧🇧"],
        numberOfPairs: 2, color: "red"),
    Theme(
        name: "Cars", emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑"],
        numberOfPairs: 4, color: "orange"),
    Theme(
        name: "Food", emojis: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍋‍🟩", "🍌", "🍉"],
        numberOfPairs: 5, color: "yellow"),
    Theme(
        name: "Animals", emojis: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"],
        numberOfPairs: 6, color: "green"),
    Theme(
        name: "Sports", emojis: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"],
        numberOfPairs: 7, color: "blue"),
    Theme(
        name: "Tech", emojis: ["⌚️", "📱", "💻", "🖥️", "🖨️", "💾", "💿", "📷"],
        numberOfPairs: 8, color: "purple"),
]

struct MemoryGame<CardContent> where CardContent: Equatable {
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var id: String
        var isFaceUp = false
        var isMatched = false
        let content: CardContent

        var debugDescription: String {
            "\(id): \(content), \(isFaceUp ? "up" : "down"), \(isMatched ? "matched" : "")"
        }
    }

    private(set) var cards: [Card]
    private var seenCardsIndices = Set<Int>()
    private(set) var score = 0

    private var indexOfFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            cards.indices.forEach {
                if cards[$0].isFaceUp && !cards[$0].isMatched && $0 != newValue {
                    if seenCardsIndices.contains($0) {
                        score -= 1
                    } else {
                        seenCardsIndices.insert($0)
                    }
                }

                cards[$0].isFaceUp = (newValue == $0)
            }
        }
    }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: "\(pairIndex + 1)a", content: content))
            cards.append(Card(id: "\(pairIndex + 1)b", content: content))
        }
    }

    mutating func shuffle() {
        print(cards)
        cards.shuffle()
    }

    mutating func choose(_ card: Card) {
        print("chose \(card)")
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {

                if let potentialMatchIndex = indexOfFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }
                } else {
                    indexOfFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
}
