//
//  EmojiArtExtensions.swift
//  Memorize
//
//  Created by Marlen Mynzhassar on 10/11/20.
//  Copyright © 2020 Marlen Mynzhassar. All rights reserved.
//

import SwiftUI

extension Data {
    // just a simple converter from a Data to a String
    var utf8: String? { String(data: self, encoding: .utf8 ) }
}
