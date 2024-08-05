//
//  PokemonTypeModel.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import SwiftData

@Model
class PokemonTypeModel {

    let slot: Int
    let name: PokemonTypeNameModel
    let url: String

    init(
        slot: Int,
        name: PokemonTypeNameModel,
        url: String
    ) {
        self.slot = slot
        self.name = name
        self.url = url
    }
}
