//
//  EmojiMemoryGameStore.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 10/18/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI
import Combine

class EmojiMemoryGameStore: ObservableObject {
    
    @Published var storedThemes = [Theme]()
    private(set) var name: String
    private var autosave: AnyCancellable? //publisher to emit changes
    
    init(named name: String = "Memorize") {
        self.name = name
        let defaultsKey = "EmojiMemoryGame.\(name)"
        
        // trying to decode json data stored in user defaults if exists
        let data = UserDefaults.standard.data(forKey: defaultsKey)
        if data != nil, let newStoredThemes = try? JSONDecoder().decode([Theme].self, from: data!) {
            storedThemes = newStoredThemes
        } else {
            addThemesToTheGame() // initial one-time setup
        }
        
        // encdoing to json format before persisting data to the user defaults
        autosave = $storedThemes.sink { themes in
            let jsonData = try! JSONEncoder().encode(themes)
            UserDefaults.standard.set(jsonData, forKey: defaultsKey)
        }
    }
    
    func addThemesToTheGame() {
        for item in EmojiTheme.allCases {
            storedThemes.append(item.theme)
        }
    }
    
    // adding new theme Untitled with default emojis
    public func addNewTheme(named name: String = "Untitled") {
        storedThemes.append(Theme(name: name, content: ["🐼","🐔","🦁", "🐙", "🐉", "🐌"],
                                  numberOfCards: 6, color: UIColor.blue.rgb))
    }
    
    public func removeTheme(_ theme: Theme) {
        storedThemes = storedThemes.filter { $0 != theme }
    }
    
    public func renameTheme(_ theme: Theme, to newName: String) {
        if let index = storedThemes.firstIndex(where: {$0 == theme}) {
            storedThemes[index].name = newName
        }
    }
}
