//
//  PokemonTypesEntity.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Foundation

struct PokemonTypesEntity: Entity {

    let slot: Int
    let type: PokemonTypeEntity
}

extension PokemonTypesEntity {

    static func == (lhs: PokemonTypesEntity, rhs: PokemonTypesEntity) -> Bool {
        return lhs.type.name == rhs.type.name
    }
}

extension PokemonTypesEntity {

    static func empty() -> Self {
        .init(
            slot: 0,
            type: .empty()
        )
    }

    static func mock() -> Self {
        .init(
            slot: 1,
            type: .mock()
        )
    }
}
