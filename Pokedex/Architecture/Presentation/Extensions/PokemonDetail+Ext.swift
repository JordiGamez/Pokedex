//
//  PokemonDetail+Ext.swift
//  Pokedex
//
//  Created by Jordi Gamez on 30/4/24.
//

import SwiftUI

extension PokemonDetail {

    var typeColor: Color {
        guard let firstType = types.first(where: { $0.slot == 1 }) else {
            return .gray // default
        }
        return firstType.color
    }
}
