//
//  MemoryGame.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 8/22/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable
{
    private(set) var cards: [Card]
    private(set) var theme: Theme
    private var seenCards: [Card]
    private(set) var score = 0
    private var lastCardChoisenTime: Date?
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    private mutating func getPenaltyPoints(cards: [Card]) -> Int {
        var penaltyPoints = 0
        for card in cards {
            seenCards.contains{$0.content == card.content} ? penaltyPoints -= 1 : seenCards.append(card)
        }
        return penaltyPoints
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if  cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    if cards[chosenIndex].hasEarnedBonus {
                        score += 6
                    } else {
                        score += 1
                    }
                } else {
                    score += getPenaltyPoints(cards: [cards[chosenIndex],cards[potentialMatchIndex]])
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                lastCardChoisenTime = Date()
            }
        }
    }
    
    init(theme:Theme) {
        self.theme = theme
        cards = [Card]()
        seenCards = [Card]()
        for pairIndex in 0..<theme.numberOfCards {
            let content = theme.createContent(pairIndex)
            cards.append(Card(content: content as! CardContent, theme: self.theme, id: pairIndex*2))
            cards.append(Card(content: content as! CardContent, theme: self.theme, id: pairIndex*2+1))
        }
        cards.shuffle()
        //print(theme.json!.utf8!)
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        
        var content: CardContent
        var theme: Theme
        var id: Int
        
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        var lastFaceUpDate: Date?
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
