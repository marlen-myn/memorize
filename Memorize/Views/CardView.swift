//
//  CardView.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 9/26/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    @State private var animatedBonusRemaining : Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration:card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        
        // card is either is face up or not matched
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    // if bonus left, then animate Pie
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining * 360-90), clockwise: true)
                            .fill(Color.orange)
                            .onAppear {
                                self.startBonusTimeAnimation() // starting bonus remaining
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining * 360-90), clockwise: true)
                            .fill(Color.orange)
                    }
                }
                .padding(5).opacity(0.4)
                .transition(.identity)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1)
                                .repeatForever(autoreverses: false) : .default)
                
            }
            .cardify(isFaceUp: card.isFaceUp, color: card.theme.color)
            .transition(AnyTransition.scale)
        }
    }
    
    // MARK: - Drawing Constants
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}
