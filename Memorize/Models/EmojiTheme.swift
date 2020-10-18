//
//  EmojiTheme.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 10/11/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

enum EmojiTheme: CaseIterable {
    
    case animals
    case sports
    case faces
    case hallowen
    case gestures
    case family
    
    var theme: Theme {
        switch self {
        case .animals: return Theme(name: "Animals", content: ["🐼","🐔","🦄","🐶","🐒","🦁", "🐙", "🐉", "🐌"], numberOfCards: 6, color: UIColor.green.rgb)
        case .sports: return Theme(name: "Sports", content: ["🏀","🏈", "⚾","🥎","🎱","🪀", "🏐", "⚽︎", "🧶"], numberOfCards: 6, color: UIColor.blue.rgb)
        case .faces: return Theme(name: "Faces", content: ["😀","😢","😉","😇","😳","🥺","🤬", "🥶", "🥰", "😎", "🤓"], numberOfCards: 6, color: UIColor.red.rgb)
        case .hallowen: return Theme(name: "Hallowen", content: ["👹","🤡","🎃","🤖","🧟‍♀️","🧛‍♂️", "👿", "👽", "💀"], numberOfCards: 6, color: UIColor.orange.rgb)
        case .gestures: return Theme(name: "Gestures", content: ["👋","✌️","💪","🤞","🤙","🖖", "🙌", "🤝", "👊", "👌"], numberOfCards: 6, color: UIColor.purple.rgb)
        case .family: return Theme(name: "Family", content: ["👼","👩‍❤️‍👨","👨‍👩‍👧","👨‍👨‍👧‍👧","👨‍👧","👨‍👧‍👧", "👬", "👩‍👦"], numberOfCards: 6, color: UIColor.gray.rgb)
        }
    }
}
