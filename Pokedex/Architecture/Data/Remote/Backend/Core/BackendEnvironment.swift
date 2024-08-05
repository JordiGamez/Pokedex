//
//  BackendEnvironment.swift
//  Pokedex
//
//  Created by Jordi Gamez on 11/6/24.
//

import Foundation

enum BackendEnvironment: String {

    case pro

    var url: String {
        switch self {
        case .pro:
            return "https://pokeapi.co/"
        }
    }
}
