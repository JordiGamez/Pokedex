//
//  PokemonStatsEntity.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Foundation

struct PokemonStatsEntity: Entity {

    let value: Int
    let stat: PokemonStatEntity

    enum CodingKeys: String, CodingKey {
        case value = "base_stat"
        case stat
    }
}

extension PokemonStatsEntity {

    static func empty() -> Self {
        .init(
            value: 0,
            stat: .empty()
        )
    }

    static func mock() -> Self {
        .init(
            value: 100,
            stat: .mock()
        )
    }
}
