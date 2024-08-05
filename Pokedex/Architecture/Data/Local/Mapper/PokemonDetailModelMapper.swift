//
//  PokemonDetailModelMapper.swift
//  Pokedex
//
//  Created by Jordi Gamez on 22/4/24.
//

import Foundation

struct PokemonDetailModelMapper {

    typealias Model = PokemonDetailModel
    typealias Entity = PokemonDetailEntity

    let id: Int?
    let name: String?
    let types: [PokemonTypesEntity]
    let height: Float?
    let weight: Float?
    let stats: [PokemonStatsEntity]

    static func map(_ entity: Entity) -> Model? {
        guard let number = entity.id,
              let name = entity.name,
              let types = mapList(entity.types),
              let height = entity.height,
              let weight = entity.weight,
              let stats = mapList(entity.stats) else {
            return nil
        }
        return .init(
            number: number,
            name: name,
            types: types,
            height: height,
            weight: weight,
            stats: stats
        )
    }
}

private extension PokemonDetailModelMapper {

    static func mapList(_ entities: [PokemonTypesEntity]) -> [PokemonTypeModel]? {
        entities.map({ map($0) }).compactMap({ $0 })
    }

    static func map(_ entity: PokemonTypesEntity) -> PokemonTypeModel? {
        .init(
            slot: entity.slot, 
            name: PokemonTypeNameModel(rawValue: entity.type.name.rawValue)!,
            url: entity.type.url
        )
    }

    static func mapList(_ entities: [PokemonStatsEntity]) -> [PokemonStatModel]? {
        entities.map({ map($0) }).compactMap({ $0 })
    }

    static func map(_ entity: PokemonStatsEntity) -> PokemonStatModel? {
        .init(
            name: entity.stat.name,
            value: entity.value,
            url: entity.stat.url
        )
    }
}
