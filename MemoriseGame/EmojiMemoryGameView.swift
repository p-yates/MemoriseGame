//
//  EmojiMemoryGameView.swift
//  MemoriseGame
//
//  Created by Paul Y on 2023-12-03.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject  var viewModel: EmojiMemoryGame

    var body: some View {
        VStack{
            HStack {
                Text(viewModel.theme.name)
                    .padding(.horizontal)
                Text("Score: \(viewModel.score)")
                    .contentTransition(.numericText())
                    .padding(.horizontal)
            }
            .font(.title)
            .padding()
            
           
                cards
                    .animation(.default, value: viewModel.cards)
            
            HStack{
                
                Button("Shuffle") {
                    viewModel.shuffle()
                }
                .padding()
                Spacer()
                Button("New game"){
                    viewModel.newGame()
                }
                .padding()
            }
        }
       .padding()
    }
    
    var cards: some View {
        
        GeometryReader { geometry in
            //send the parameters to the func gridItemWidthThatFits
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: 2/3
            )
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize),spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) {card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(viewModel.theme.color)
    }
    
    func gridItemWidthThatFits (
    count: Int,
    size: CGSize,
    atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        //need to calculate what will fit
        //try one column, see if it fits, if not try two, keep trying until it fits vertically
        //use a repeat while
        let count = CGFloat(count) //type conversion, or it won't take the non float version. This overrides the other version of count
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            
            let rowCount = (count / columnCount.rounded(.up))
            if rowCount * height < size.height {
                //it fits, so we're done
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
            
        } while columnCount < count
        //no point adding more columns that the unmber of items, it can't help
        
        return min(size.width / count , size.height * aspectRatio).rounded(.down)
    }
}

struct CardView: View {
    let card: MemoriseGame<String>.Card

    init(_ card: MemoriseGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 8)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 150))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
