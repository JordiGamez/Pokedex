//
//  FavoritePokemonList.swift
//  Pokedex
//
//  Created by Jordi Gamez on 14/5/24.
//

import SwiftData

@Model
class FavoritePokemonList {

    @Attribute(.unique) let number: Int

    init(number: Int) {
        self.number = number
    }
}
