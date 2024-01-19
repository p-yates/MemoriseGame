//
//  Theme.swift
//  MemoriseGame
//
//  Created by Paul Y on 2024-01-17.
//

import Foundation
import SwiftUI

enum Theme: CaseIterable {
    case animals
    case halloween
    case fruit
    case places
    case plants
    case party
    
    var name: String {
        switch self {
        case .animals:
            "Animals"
        case .halloween:
            "Spooky"
        case .fruit:
            "Fruit"
        case .places:
            "Places"
        case .plants:
            "Plants"
        case .party:
            "Party"
        }
    }
    
    var emojis: [String] {
        switch self {
        case .animals:
            return ["🐝","🦋","🐌","🐞","🐠","🦀","🐢","🐙","🦐","🦨", "🦚"]
        case .halloween:
            return ["🎃","👻","🕷️","🦇","🍭","🍬","🕸️","🧛","🧟","🔮"]
        case .fruit:
            return ["🍎","🍌","🍇","🍊","🍓","🍍","🥭","🍒","🍑","🍏"]
        case .places:
            return ["🏠","🏢","⛪","🏰","🏞️","🏖️","🌆","🌃","🏙️","🗽"]
        case .plants:
            return ["🌲","🌳","🌸","🌺","🍃","🌻","🌵","🌿","🍀","🎋"]
        case .party:
            return ["🎉","🥳","🎊","🎈","🍾","🎁","🍰","🎂","🎤","🎶"]
        }
    }
    
    var color: Color {
        switch self {
        case .animals:
                .red
        case .halloween:
                .orange
        case .fruit:
                .green
        case .places:
                .teal
        case .plants:
                .yellow
        case .party:
                .blue
        }
    }
}
