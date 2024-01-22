//
//  CardView.swift
//  MemoriseGame
//
//  Created by Paul Y on 2024-01-21.
//

import SwiftUI

struct CardView: View {
    let card: MemoriseGame<String>.Card
    
    init(_ card: MemoriseGame<String>.Card) {
        self.card = card
    }
    

    
    var body: some View {
        
        Pie(endAngle: .degrees(90))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .modifier(Cardify(isFaceUp: card.isFaceUp))
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    
    private struct Constants {

        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let inset: CGFloat = 10
            static let opacity: CGFloat = 0.4
        }
    }
}


struct CardView_Previews: PreviewProvider {
    typealias Card = MemoriseGame<String>.Card
    static var previews: some View {
        HStack {
            CardView(Card(content: "🥑", id: "1a"))
            CardView(Card(isFaceUp: true, content: "a card with some long string in", id: "1a"))
            CardView(Card(isFaceUp: true, isMatched: true, content: "🥑", id: "1a"))

        }
        .aspectRatio(2/3, contentMode: .fit)
        .padding()
        .foregroundColor(.teal)
    }
}
