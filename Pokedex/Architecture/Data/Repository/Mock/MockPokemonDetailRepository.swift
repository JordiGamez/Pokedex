//
//  MockPokemonDetailRepository.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Foundation

struct MockPokemonDetailRepository: PokemonDetailRepositoryProtocol {

    var pokemonDetail: PokemonDetailEntity?
    var pokemonDetailList: [PokemonDetailEntity]?

    func getPokemonDetail(_ number: Int) async throws -> PokemonDetailEntity? {
        pokemonDetail
    }

    func getAllPokemonDetail() async throws -> [PokemonDetailEntity]? {
        pokemonDetailList
    }
}
