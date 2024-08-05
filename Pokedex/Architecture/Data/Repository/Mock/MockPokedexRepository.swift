//
//  MockPokedexRepository.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Foundation

struct MockPokedexRepository: PokedexRepositoryProtocol {

    var pokedex: PokedexEntity?

    func getPokedex() async throws -> PokedexEntity? {
        pokedex
    }
}
