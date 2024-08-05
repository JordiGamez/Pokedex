//
//  PokemonTypeNameEntity.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Foundation

enum PokemonTypeNameEntity: String, Entity {

    case normal
    case grass
    case poison
    case fire
    case psychic
    case flying
    case ice
    case bug
    case rock
    case water
    case electric
    case ground
    case fairy
    case steel
    case fighting
    case dragon
    case ghost
    case dark
}

extension PokemonTypeNameEntity {

    static func empty() -> PokemonTypeNameEntity {
        .normal
    }

    static func mock() -> PokemonTypeNameEntity {
        .electric
    }
}
