//
//  ThemeView.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 10/18/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct ThemeView: View {
    var theme: Theme
    @State private var showThemeEditor = false
    @EnvironmentObject var store: EmojiMemoryGameStore
    @Binding var editMode : EditMode
    
    var body: some View {
        HStack {
            if editMode != .inactive {
                HStack {
                    Image(systemName: "pencil.circle.fill").imageScale(.large).foregroundColor(theme.color)
                        .onTapGesture {
                            showThemeEditor = true
                        }
                        .sheet(isPresented: $showThemeEditor, onDismiss: {
                            editMode = EditMode.inactive
                        }) {
                            ThemeEditor(theme: theme, showThemeEditor: $showThemeEditor)
                                .environmentObject(store)
                        }
                }
                .padding(.horizontal)
            }
            VStack {
                HStack {
                    Text(theme.name).font(Font.system(.largeTitle)).foregroundColor(theme.color)
                    Spacer()
                }
                HStack {
                    Text("\(theme.numberOfCards) pairs from \(theme.content.joined())")
                    Spacer()
                }
            }
        }
    }
}
