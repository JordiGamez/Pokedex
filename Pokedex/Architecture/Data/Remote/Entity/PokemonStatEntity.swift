//
//  PokemonStatEntity.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Foundation

struct PokemonStatEntity: Entity {

    let name: String
    let url: String
}

extension PokemonStatEntity {

    static func empty() -> Self {
        .init(
            name: "",
            url: ""
        )
    }

    static func mock() -> Self {
        .init(
            name: "hp",
            url: "https://pokeapi.co/api/v2/stat/1/"
        )
    }
}
