//
//  MemorizeGameApp.swift
//  MemorizeGame
//
//  Created by Marlen Mynzhassar on 10/18/20.
//

import SwiftUI

@main
struct MemorizeGameApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameChooser()
                .environmentObject(EmojiMemoryGameStore(named: "Memorize"))
        }
    }
}
