//
//  PokedexEntityMapper.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokedexEntityMapper {

    static func mapList(_ models: [PokemonInfoModel]) -> PokedexEntity {
        .init(
            count: models.count,
            pokemon: models.map({ map($0) })
        )
    }
}

private extension PokedexEntityMapper {

    static func map(_ model: PokemonInfoModel) -> PokemonInfoEntity {
        .init(
            name: model.name,
            url: model.url
        )
    }
}
