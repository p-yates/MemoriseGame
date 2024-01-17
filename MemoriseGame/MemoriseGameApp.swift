//
//  MemoriseGameApp.swift
//  MemoriseGame
//
//  Created by Paul Y on 2023-12-03.
//

import SwiftUI

@main
struct MemoriseGameApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
