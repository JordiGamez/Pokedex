//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Jordi Gamez on 11/6/24.
//

import Foundation
import API

extension API.Backend {

    enum PokemonAPI: URLRequestConvertible {

        case pokedex
        case pokemon(id: Int)

        var method: HTTPMethod {
            switch self {
            case .pokedex, .pokemon:
                return .get
            }
        }
        
        var endpoint: URL? {
            switch self {
            case .pokedex:
                return URL(string: HTTPConstants.v2BaseURL + "v2/pokemon?limit=20000")
            case .pokemon(let id):
                return URL(string: HTTPConstants.v2BaseURL + "v2/pokemon/\(id)")
            }
        }
    }
}
