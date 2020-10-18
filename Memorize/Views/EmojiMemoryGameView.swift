//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 8/20/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            // Upper view panel
            HStack {
                // starts a new game
                Button(action:{
                    withAnimation(.easeInOut){
                        self.viewModel.startNewGame()
                    }
                }) {
                    HStack {
                        Image(systemName: "plus")
                        Text("New Game")
                    }
                    .padding(10.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10.0)
                            .stroke(lineWidth: 2.0)
                    )
                }
                Spacer()
                Text("Score: \(self.viewModel.score)")
            }
            .padding()
            Divider()
            // main content view
            VStack {
                Grid(viewModel.cards) { card in
                    CardView(card:card).onTapGesture {
                        withAnimation(.linear(duration:0.75)) {
                            self.viewModel.choose(card: card)
                        }
                    }
                    .padding(5)
                }
                .padding()
            }
        }
    }
}
