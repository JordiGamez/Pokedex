//
//  PokemonTypeEntity.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Foundation

struct PokemonTypeEntity: Entity {

    let name: PokemonTypeNameEntity
    let url: String
}

extension PokemonTypeEntity {

    static func empty() -> PokemonTypeEntity {
        .init(
            name: .empty(),
            url: ""
        )
    }

    static func mock() -> PokemonTypeEntity {
        .init(
            name: .mock(),
            url: "https://pokeapi.co/api/v2/type/13/"
        )
    }
}
