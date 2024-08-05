//
//  PokemonInfoMapper.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokemonInfoMapper {

    typealias DomainModel = PokemonInfo
    typealias Model = PokemonInfoModel
    typealias Entity = PokemonInfoEntity

    static func mapList(_ entities: [Entity]) -> [DomainModel] {
        entities.map({ map($0) }).compactMap({ $0 })
    }

    static func mapList(_ models: [Model]) -> [DomainModel] {
        models.map({ map($0) })
    }
}

private extension PokemonInfoMapper {

    static func map(_ entity: Entity) -> DomainModel? {
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

    static func map(_ model: Model) -> DomainModel {
        .init(
            number: model.number,
            name: model.name,
            url: model.url
        )
    }
}
