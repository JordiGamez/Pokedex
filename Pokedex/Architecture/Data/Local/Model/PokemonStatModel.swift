//
//  PokemonStatModel.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import SwiftData

@Model
class PokemonStatModel {

    let name: String
    let value: Int
    let url: String

    init(
        name: String,
        value: Int,
        url: String
    ) {
        self.name = name
        self.value = value
        self.url = url
    }
}
