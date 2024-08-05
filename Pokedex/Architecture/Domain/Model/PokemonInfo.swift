//
//  PokemonInfo.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokemonInfo: DomainModel {

    let number: Int
    let name: String
    let url: String
}

extension PokemonInfo {

    var numberFormatted: String {
        String(format: "%04d", number)
    }

    var imageURL: String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(number).png"
    }
}

extension PokemonInfo {

    static func empty() -> Self {
        .init(
            number: 1,
            name: "",
            url: ""
        )
    }

    static func mock() -> Self {
        .init(
            number: 25,
            name: "pikachu",
            url: "https://pokeapi.co/api/v2/pokemon/25/"
        )
    }

    static func mockList() -> [Self] {
        [
            .init(
                number: 1,
                name: "bulbasaur",
                url: "https://pokeapi.co/api/v2/pokemon/1/"
            ),
            .init(
                number: 2,
                name: "ivysaur",
                url: "https://pokeapi.co/api/v2/pokemon/2/"
            ),
            .init(
                number: 3,
                name: "venusaur",
                url: "https://pokeapi.co/api/v2/pokemon/3/"
            ),
            .init(
                number: 4,
                name: "charmander",
                url: "https://pokeapi.co/api/v2/pokemon/4/"
            ),
            .init(
                number: 5,
                name: "charmeleon",
                url: "https://pokeapi.co/api/v2/pokemon/5/"
            ),
            .init(
                number: 6,
                name: "charizard",
                url: "https://pokeapi.co/api/v2/pokemon/6/"
            ),
            .init(
                number: 7,
                name: "squirtle",
                url: "https://pokeapi.co/api/v2/pokemon/7/"
            ),
            .init(
                number: 8,
                name: "wartortle",
                url: "https://pokeapi.co/api/v2/pokemon/8/"
            ),
            .init(
                number: 9,
                name: "blastoise",
                url: "https://pokeapi.co/api/v2/pokemon/9/"
            )
        ]
    }
}
