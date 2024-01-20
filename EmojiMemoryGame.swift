//
//  EmojiMemoryGame.swift
//  MemoriseGame
//
//  Created by Paul Y on 2023-12-10.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    lazy var theme: Theme = .animals
    
    private static func createMemoryGame(withInitialScore initialScore: Int, theme: Theme) -> MemoriseGame<String> {
        print(theme)
        print(theme.color)
        print(initialScore)
        return MemoriseGame(score: initialScore, numberOfPairsOfCards: theme.emojis.count) { pairIndex in
            if (theme.emojis.indices.contains(pairIndex)) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame(withInitialScore: 0, theme: .animals)
    
    var cards: Array<MemoriseGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoriseGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame(withInitialScore initialScore: Int = 0) {
        model = EmojiMemoryGame.createMemoryGame(withInitialScore: initialScore, theme: randomisedTheme())
        shuffle()
    }
    
    func randomisedTheme() -> Theme {
        theme = Theme.allCases.randomElement()!
        return theme
    }
}
