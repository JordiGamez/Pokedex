//
//  PokemonInfoModel.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import SwiftData

@Model
class PokemonInfoModel {

    @Attribute(.unique) let number: Int
    let name: String
    let url: String

    init(
        number: Int,
        name: String,
        url: String
    ) {
        self.number = number
        self.name = name
        self.url = url
    }
}
