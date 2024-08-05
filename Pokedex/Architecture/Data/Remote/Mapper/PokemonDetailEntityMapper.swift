//
//  PokemonDetailEntityMapper.swift
//  Pokedex
//
//  Created by Jordi Gamez on 22/4/24.
//

import Foundation

struct PokemonDetailEntityMapper {

    static func mapList(_ models: [PokemonDetailModel]) -> [PokemonDetailEntity] {
        models.map({ map($0) })
    }

    static func map(_ model: PokemonDetailModel) -> PokemonDetailEntity {
        .init(
            id: model.number,
            name: model.name,
            types: map(model.types),
            height: model.height,
            weight: model.weight,
            stats: map(model.stats)
        )
    }
}

private extension PokemonDetailEntityMapper {

    static func map(_ models: [PokemonTypeModel]) -> [PokemonTypesEntity] {
        models.map {
            .init(
                slot: $0.slot,
                type: .init(name: PokemonTypeNameEntity(rawValue: $0.name.rawValue)!, url: $0.url)
            )
        }
    }

    static func map(_ models: [PokemonStatModel]) -> [PokemonStatsEntity] {
        models.map {
            .init(
                value: $0.value,
                stat: .init(
                    name: $0.name,
                    url: $0.url
                )
            )
        }
    }
}
