//
//  EmojiMemoryGameChooser.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 10/18/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameChooser: View {
    
    @EnvironmentObject var store: EmojiMemoryGameStore
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(store.storedThemes) { theme in
                        NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(with: theme))
                                        .navigationBarTitle(theme.name)
                        ) {
                            ThemeView(theme: theme, editMode: $editMode)
                                .environmentObject(store)
                        }
                    }.onDelete { indexSet in
                        indexSet.map { self.store.storedThemes[$0] }.forEach { theme in
                            store.removeTheme(theme)
                        }
                    }
                }
                .navigationBarTitle(store.name, displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        withAnimation {
                            store.addNewTheme()
                        }
                    }, label: {
                        Image(systemName: "plus").imageScale(.large)
                    }),
                    trailing: EditButton()
                )
                .environment(\.editMode, $editMode)
            }
        }
    }
}
