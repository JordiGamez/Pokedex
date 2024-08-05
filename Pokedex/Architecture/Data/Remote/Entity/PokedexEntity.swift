//
//  PokedexEntity.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokedexEntity: Entity {
    
    let count: Int?
    let pokemon: [PokemonInfoEntity]

    enum CodingKeys: String, CodingKey {
        case count
        case pokemon = "results"
    }
}

extension PokedexEntity {
    
    static func empty() -> Self {
        .init(
            count: nil,
            pokemon: []
        )
    }

    static func mock() -> Self {
        .init(
            count: 1,
            pokemon: [
                .init(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25/")
            ]
        )
    }
}
