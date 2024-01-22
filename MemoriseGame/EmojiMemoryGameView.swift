//
//  EmojiMemoryGameView.swift
//  MemoriseGame
//
//  Created by Paul Y on 2023-12-03.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject  var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
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
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: aspectRatio) {card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(viewModel.theme.color)
    }
}


struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
