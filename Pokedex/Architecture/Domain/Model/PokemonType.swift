//
//  PokemonType.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokemonType: DomainModel {

    let slot: Int
    let name: PokemonTypeName
    let url: String
}

extension PokemonType {
    
    var id: String {
        url.components(separatedBy: "/")[6]
    }
}

extension PokemonType {

    static func empty() -> Self {
        .init(
            slot: 0,
            name: .none, 
            url: ""
        )
    }

    static func mock() -> Self {
        .init(
            slot: 1,
            name: .electric,
            url: "https://pokeapi.co/api/v2/type/13/"
        )
    }
}
