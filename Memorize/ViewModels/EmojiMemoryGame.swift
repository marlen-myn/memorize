//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 8/22/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(theme:theme)
    }
    
    // initialize game with particular theme
    init (with theme: Theme) {
        self.model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    func startNewGame() {
        self.model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    // MARK: - Access to the Model
    
    var score: Int {
        model.score
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var theme: Theme {
        model.theme
    }
    
    //MARK: - Intent(s)
    
    func choose (card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
