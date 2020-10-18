//
//  Theme.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 10/11/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

struct Theme: Codable, Identifiable, Hashable {
    
    let id: UUID
    var name: String
    var content: [String]
    var numberOfCards:Int
    var rgbColor: UIColor.RGB
    
    var color: Color {
        Color(rgbColor)
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init (name:String, content:[String], numberOfCards:Int, color: UIColor.RGB, id: UUID? = nil) {
        self.id = id ?? UUID()
        self.name = name
        self.content = content
        self.content.shuffle()
        self.numberOfCards = numberOfCards
        self.rgbColor = color
    }
    
    func createContent(_ index: Int) -> String {
        return self.content[index]
    }
}
