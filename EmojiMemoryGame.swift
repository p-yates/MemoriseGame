//
//  EmojiMemoryGame.swift
//  MemoriseGame
//
//  Created by Paul Y on 2023-12-10.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🐝","🦋","🐌","🐞","🐠","🦀","🐢","🐙","🦐","🦨", "🦚"]
    
    private static func createMemoryGame() -> MemoriseGame<String> {
        return MemoriseGame(numberOfPairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    @Published private var model = createMemoryGame()
    
    
    var cards: Array<MemoriseGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoriseGame<String>.Card) {
        model.choose(card)
    }
}
