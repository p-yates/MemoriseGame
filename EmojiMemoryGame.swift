//
//  EmojiMemoryGame.swift
//  MemoriseGame
//
//  Created by Paul Y on 2023-12-10.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static func createMemoryGame() -> MemoriseGame<String> {
        let theme = Theme.allCases.randomElement()!
        print(theme)
        print(theme.color)
        let cardColorTheme = theme.color
        return MemoriseGame(theme: theme, numberOfPairsOfCards: theme.emojis.count) { pairIndex in
            if (theme.emojis.indices.contains(pairIndex)) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoriseGame<String>.Card> {
        return model.cards
    }
    
    var theme: Theme {
            return model.theme
        }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoriseGame<String>.Card) {
        model.choose(card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
        shuffle()
    }
}
