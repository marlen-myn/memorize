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
    @State private var emojiToAdd = ""
    @State private var selectedColor: Color = Color.black
    
    var body: some View {
        VStack(spacing:0) {
            ZStack {
                Text(theme.name).font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        showThemeEditor = false
                    }) { Text("Done").foregroundColor(.blue).padding() }
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
                Section(header: Text("Add emoji")) {
                    HStack {
                        TextField("Emoji", text: $emojiToAdd)
                        Spacer()
                        Button(action: {
                            store.addEmoji(emojiToAdd, to: theme)
                            emojiToAdd = ""
                        }) { Text("Add").foregroundColor(.blue) }
                    }
                }
                Section(header:
                            HStack {
                                Text("Emojis")
                                Spacer()
                                Text("tap emoji to exclude").font(.system(size: 10)).textCase(.lowercase)
                            },
                        footer: theme.isAllowedToRemojeEmoji() ? Text("") : Text("No emoji can be deleted. Minimum number: \(theme.numberOfCards)")
                ) {
                    Grid(theme.content, id: \.self ) { emoji in
                        Text(emoji)
                            .font(Font.system(size: self.fontSize))
                            .onTapGesture(count:1) {
                                store.removeEmoji(emoji, from: theme)
                            }
                    }.frame(height:self.height)
                }
                Section(header: Text("Card Count")) {
                    HStack {
                        Text("\(theme.numberOfCards) Pairs")
                        Spacer()
                        Stepper(onIncrement: {
                            store.inreaseNumberOfCards(for: theme)
                        }, onDecrement: {
                            store.decreaseNumberOfCards(for: theme)
                        }, label: { EmptyView() })
                    }
                }
                Section(header: Text("Color")) {
                    ColorPicker (
                        "Pick a color",
                        selection: $selectedColor
                    ).foregroundColor(selectedColor)
                    .onChange(of: selectedColor, perform: { value in
                        store.changeThemeColor(selectedColor, for: theme)
                    })
                }
            }
        }
        .onAppear {
            themeName = theme.name
            selectedColor = theme.color
        }
    }
    
    var height: CGFloat {
        CGFloat((theme.content.count - 1) / 6) * 70 + 70
    }
    
    let fontSize: CGFloat = 40
}
