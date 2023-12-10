//
//  ContentView.swift
//  MemoriseGame
//
//  Created by Paul Y on 2023-12-03.
//

import SwiftUI


struct ContentView: View {
    
    @State var emojiType: EmojiType = .bugs
    @State private var emojis: [String] = ["🐝","🦋","🐌","🐞","🐠","🦀","🐢","🐙","🦐","🦨", "🦚"]
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack {
            Text("Memorise!")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            cards
            Spacer()
            HStack{
                Button(action: {
                    emojiType = .bugs
                    emojis = emojiType.emojiList
                    cardCount = emojiType.emojiList.count
                }, label: {
                    VStack{
                        Image(systemName: "ladybug.fill").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text("Bugs")
                    }
                })
                
                .padding()
                
                Button(action: {
                    emojiType = .places
                    emojis = emojiType.emojiList
                    cardCount = emojiType.emojiList.count
                }, label: {
                    VStack{
                        Image(systemName: "pin.fill").font(.title)
                        Text("Places")
                    }
                })
                
                .padding()
                
                Button(action: {
                    emojiType = .veggie
                    emojis = emojiType.emojiList
                    cardCount = emojiType.emojiList.count
                }, label: {
                    VStack{
                        Image(systemName: "carrot.fill").font(.title)
                        Text("Veggies")
                    }
                })
                
                .padding()
            }
            cardCountAdjusters
        }
        .padding()
        .onAppear {
            emojis = emojiType.emojiList
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.teal)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer ()
            cardAdder
        }
        .padding()
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojiType.emojiList.count)
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "minus.circle.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "plus.circle.fill")
    }
}

enum EmojiType {
    case bugs
    case veggie
    case places
    
    var emojiList: [String] {
        switch self {
        case .bugs:
            return [ "🐝","🦋","🐌","🐞","🐠","🦀","🐢","🐙","🦐","🦨", "🦚",
                     "🐝","🦋","🐌","🐞","🐠","🦀","🐢","🐙","🦐","🦨", "🦚"].shuffled()
        case .veggie:
            return ["🥑","🌽", "🧄", "🍉",
                    "🥑","🌽", "🧄", "🍉"].shuffled()
        case .places:
            return [ "🗽","🏰", "🌋", "🗿", "⛩️",
                     "🗽","🏰", "🌋", "🗿", "⛩️"].shuffled()
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 8)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
                    .padding()
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
