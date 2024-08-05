//
//  PokemonInfoEntity.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokemonInfoEntity: Entity {

    let name: String?
    let url: String?
}

extension PokemonInfoEntity {

    var number: Int? {
        Int(url?.components(separatedBy: "/")[6] ?? "") ?? nil
    }
}

extension PokemonInfoEntity {

    static func empty() -> PokemonInfoEntity {
        .init(
            name: nil,
            url: nil
        )
    }

    static func mock() -> PokemonInfoEntity {
        .init(
            name: "pikachu",
            url: "https://pokeapi.co/api/v2/pokemon/25/"
        )
    }
}
