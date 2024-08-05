//
//  PokemonDetailMapper.swift
//  Pokedex
//
//  Created by Jordi Gamez on 22/4/24.
//

import Foundation

struct PokemonDetailMapper {

    typealias DomainModel = PokemonDetail
    typealias Entity = PokemonDetailEntity

    static func mapList(_ entities: [Entity]) -> [DomainModel] {
        entities.map({ map($0) }).compactMap({ $0 })
    }

    static func map(_ entity: Entity) -> DomainModel? {
        guard let id = entity.id, 
              let name = entity.name,
              let height = entity.height,
              let weight = entity.weight else {
            return nil
        }
        return .init(
            number: id,
            name: name,
            types: map(entity.types),
            height: height,
            weight: weight,
            stats: map(entity.stats)
        )
    }
}

private extension PokemonDetailMapper {

    static func map(_ entities: [PokemonTypesEntity]) -> [PokemonType] {
        entities.map {
            .init(
                slot: $0.slot, 
                name: PokemonTypeName(rawValue: $0.type.name.rawValue)!,
                url: $0.type.url
            )
        }
    }

    static func map(_ entities: [PokemonStatsEntity]) -> [PokemonStat] {
        entities.map {
            .init(
                slot: Int($0.stat.url.components(separatedBy: "/")[6]) ?? 0,
                name: $0.stat.name,
                value: $0.value
            )
        }
    }
}
