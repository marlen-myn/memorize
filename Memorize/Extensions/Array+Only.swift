//
//  Array+Only.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 8/31/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil 
    }
}
