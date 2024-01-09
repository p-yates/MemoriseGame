//
//  EmojiMemoryGame.swift
//  MemoriseGame
//
//  Created by Paul Y on 2023-12-10.
//

import SwiftUI

class EmojiMemoryGame {
    private static let emojis = ["🐝","🦋","🐌","🐞","🐠","🦀","🐢","🐙","🦐","🦨", "🦚"]
    
    private static func createMemoryGame() -> MemoriseGame<String> {
        return MemoriseGame(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️⁉️"
            }
        }
    }
    
    
//    private var model = MemoriseGame(numberOfPairsOfCards: 4) { pairIndex in
//            return emojis[pairIndex]
//        }
    
    private var model = createMemoryGame()
    
    
    var cards: Array<MemoriseGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoriseGame<String>.Card) {
        model.choose(card)
    }
}
