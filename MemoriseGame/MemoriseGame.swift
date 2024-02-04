//
//  MemoriseGame.swift
//  MemoriseGame
//
//  Created by Paul Y on 2023-12-10.
//

import Foundation

struct MemoriseGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    var score: Int
    
    init(score: Int, numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.score = score
        cards = []
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        shuffle()
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { return cards.indices.filter {index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards [$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        
        guard let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
       
        //check it's a valid card to select
        if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            
            // checks if there is already a card face up
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                
                //if the two chosen cards match, set them to matched and add 2 to the score
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2 //2 points for a sucessful match
                    print(score)
                    
                //if the two chosen cards don't match and either of them has already been seen, reduce the score
                } else {
                    if cards[chosenIndex].hasBeenSeen || cards[potentialMatchIndex].hasBeenSeen {
                        score -= 1
                        print(score)
                    }
                    
                    //set the cards to has been seen (we've already done all the other checks on them by this point
                    cards[chosenIndex].hasBeenSeen = true
                    cards[potentialMatchIndex].hasBeenSeen = true
                }
                
                //if there was not already a card face up, then the once we selected will become the only face up card, at the index chosen so set it and put it face up
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
            
        }
    }
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        var isFaceUp = false
        var isMatched = false
        var hasBeenSeen = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched  ? "matched" : "") \(hasBeenSeen ? "seen" : "unseen")"
        }
    }
}
extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
