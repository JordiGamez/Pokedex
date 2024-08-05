//
//  PokemonInfoModelMapper.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokemonInfoModelMapper {

    typealias Model = PokemonInfoModel
    typealias Entity = PokemonInfoEntity

    static func mapList(_ entities: [Entity]) -> [Model] {
        entities.map({ map($0) }).compactMap({ $0 })
    }
}

private extension PokemonInfoModelMapper {

    static func map(_ entity: Entity) -> Model? {
        guard let number = entity.number,
              let name = entity.name,
              let url = entity.url else {
            return nil
        }
        return .init(
            number: number,
            name: name,
            url: url
        )
    }
}
