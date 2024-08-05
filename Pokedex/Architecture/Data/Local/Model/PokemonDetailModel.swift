//
//  PokemonDetailModel.swift
//  Pokedex
//
//  Created by Jordi Gamez on 22/4/24.
//

import SwiftData

@Model
class PokemonDetailModel {

    @Attribute(.unique) let number: Int
    let name: String
    let types: [PokemonTypeModel]
    let height: Float
    let weight: Float
    let stats: [PokemonStatModel]

    init(
        number: Int,
        name: String,
        types: [PokemonTypeModel],
        height: Float,
        weight: Float,
        stats: [PokemonStatModel]
    ) {
        self.number = number
        self.name = name
        self.types = types
        self.height = height
        self.weight = weight
        self.stats = stats
    }
}
