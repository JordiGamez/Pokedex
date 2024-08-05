//
//  PokemonStat.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

struct PokemonStat: DomainModel {

    let slot: Int
    let name: String
    let value: Int
}

extension PokemonStat {

    var nameFormated: String {
        name.replacingOccurrences(of: "-", with: " ")
    }

    var abbreviation: String {
        if name == "hp" {
            return "HP"
        }
        if name == "attack" {
            return "ATK"
        }
        if name == "defense" {
            return "DEF"
        }
        if name == "special-attack" {
            return "SATK"
        }
        if name == "special-defense" {
            return "SDEF"
        }
        if name == "speed" {
            return "SPD"
        }
        return ""
    }
}

extension PokemonStat {

    static func empty() -> Self {
        .init(
            slot: 0,
            name: "",
            value: 0
        )
    }

    static func mock() -> Self {
        .init(
            slot: 1,
            name: "HP",
            value: 100
        )
    }
}
