//
//  PokemonType+Ext.swift
//  Pokedex
//
//  Created by Jordi Gamez on 30/4/24.
//

import SwiftUI

extension PokemonType {

    var color: Color {
        .init("type-\(self.name.rawValue)", bundle: .main)
    }
}
