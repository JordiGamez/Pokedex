//
//  PokemonDetailEntity.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokemonDetailEntity: Entity {

    let id: Int?
    let name: String?
    let types: [PokemonTypesEntity]
    let height: Float?
    let weight: Float?
    let stats: [PokemonStatsEntity]
}

extension PokemonDetailEntity {

    static func empty() -> Self {
        .init(
            id: nil,
            name: nil,
            types: [],
            height: nil,
            weight: nil,
            stats: []
        )
    }
    
    static func mock() -> Self {
        .init(
            id: 25,
            name: "pikachu",
            types: [
                .init(slot: 1, type: .init(name: .electric, url: "https://pokeapi.co/api/v2/type/13/"))
            ],
            height: 4,
            weight: 60,
            stats: [
                .init(value: 10, stat: .init(name: "HP", url: "https://pokeapi.co/api/v2/stat/1/")),
                .init(value: 20, stat: .init(name: "ATTACK", url: "https://pokeapi.co/api/v2/stat/2/")),
                .init(value: 30, stat: .init(name: "DEFENSE", url: "https://pokeapi.co/api/v2/stat/3/")),
                .init(value: 40, stat: .init(name: "SPECIAL-ATTACK", url: "https://pokeapi.co/api/v2/stat/4/")),
                .init(value: 50, stat: .init(name: "SPECIAL-DEFENSE", url: "https://pokeapi.co/api/v2/stat/5/")),
                .init(value: 60, stat: .init(name: "SPEED", url: "https://pokeapi.co/api/v2/stat/6/"))
            ]
        )
    }
}
