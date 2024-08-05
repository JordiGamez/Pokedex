//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokemonDetail: DomainModel {

    let number: Int
    let name: String
    let types: [PokemonType]
    let height: Float
    let weight: Float
    let stats: [PokemonStat]
}

extension PokemonDetail {

    var numberFormatted: String {
        String(format: "%04d", number)
    }

    var imageURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(number).png"
    }

    var orderedStats: [PokemonStat] {
        stats.sorted(by: { first, second in first.slot < second.slot })
    }
}

extension PokemonDetail {

    static func == (lhs: PokemonDetail, rhs: PokemonDetail) -> Bool {
        lhs.number == rhs.number
    }
}

extension PokemonDetail {

    static func empty() -> Self {
        .init(
            number: 0,
            name: "",
            types: [],
            height: 0,
            weight: 0,
            stats: []
        )
    }

    static func mock() -> Self {
        .init(
            number: 25,
            name: "pikachu",
            types: [.init(slot: 1, name: .electric, url: "https://pokeapi.co/api/v2/type/13/")],
            height: 4,
            weight: 60,
            stats: [
                .init(slot: 1, name: "HP", value: 10),
                .init(slot: 2, name: "ATTACK", value: 20),
                .init(slot: 3, name: "DEFENSE", value: 30),
                .init(slot: 4, name: "SPECIAL-ATTACK", value: 40),
                .init(slot: 5, name: "SPECIAL-DEFENSE", value: 50),
                .init(slot: 6, name: "SPEED", value: 60)
            ]
        )
    }

    static func mockList() -> [Self] {
        [
            .init(
                number: 25,
                name: "pikachu",
                types: [.init(slot: 1, name: .electric, url: "https://pokeapi.co/api/v2/type/13/")],
                height: 4,
                weight: 60,
                stats: [
                    .init(slot: 1, name: "HP", value: 10),
                    .init(slot: 2, name: "ATTACK", value: 20),
                    .init(slot: 3, name: "DEFENSE", value: 30),
                    .init(slot: 4, name: "SPECIAL-ATTACK", value: 40),
                    .init(slot: 5, name: "SPECIAL-DEFENSE", value: 50),
                    .init(slot: 6, name: "SPEED", value: 60)
                ]
            ),
            .init(
                number: 26,
                name: "raichu",
                types: [.init(slot: 1, name: .electric, url: "https://pokeapi.co/api/v2/type/13/")],
                height: 14,
                weight: 90,
                stats: [
                    .init(slot: 1, name: "HP", value: 20),
                    .init(slot: 2, name: "ATTACK", value: 30),
                    .init(slot: 3, name: "DEFENSE", value: 40),
                    .init(slot: 4, name: "SPECIAL-ATTACK", value: 50),
                    .init(slot: 5, name: "SPECIAL-DEFENSE", value: 60),
                    .init(slot: 6, name: "SPEED", value: 70)
                ]
            )
        ]
    }
}
