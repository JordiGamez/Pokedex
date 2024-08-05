//
//  GridItem+Ext.swift
//  Pokedex
//
//  Created by Jordi Gamez on 26/3/24.
//

import SwiftUI

public extension [GridItem] {

    static func grid(_ number: Int) -> [GridItem] {
        (0..<number).map { _ in GridItem() }
    }
}
