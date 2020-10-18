//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 10/18/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct ThemeEditor: View {
    
    @EnvironmentObject var store: EmojiMemoryGameStore
    var theme: Theme
    @Binding var showThemeEditor: Bool
    @State private var themeName: String = ""
    
    var body: some View {
        VStack(spacing:0) {
            ZStack {
                Text("Theme Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        showThemeEditor = false
                    }) { Text("Done").padding() }
                }
            }
            Divider()
            Form {
                Section() {
                    TextField("Theme Name", text: $themeName, onEditingChanged: { began in
                        if !began {
                            store.renameTheme(theme, to: themeName)
                        }
                    })
                }
            }
        }
        .onAppear {
            themeName = theme.name
        }
    }
}
