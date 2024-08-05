//
//  PokedexRepository.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Foundation
import ComposableArchitecture
import API

protocol PokedexRepositoryProtocol {

    func getPokedex() async throws -> PokedexEntity?
}

extension DependencyValues {

    var pokedexRepository: PokedexRepositoryProtocol {
        get { self[PokedexRepositoryKey.self] }
        set { self[PokedexRepositoryKey.self] = newValue }
    }
}

struct PokedexRepositoryKey: DependencyKey {
    
    static var liveValue: PokedexRepositoryProtocol = PokedexRepository()
    static var testValue: PokedexRepositoryProtocol = MockPokedexRepository()
}

struct PokedexRepository: PokedexRepositoryProtocol {

    func getPokedex() async throws -> PokedexEntity? {
        guard let pokemon = await getLocalPokedexIfAvailable() else {
            return try await getRemotePokedexIfAvailable()
        }
        return PokedexEntityMapper.mapList(pokemon)
    }
}

private extension PokedexRepository {

    func getLocalPokedexIfAvailable() async -> [PokemonInfoModel]? {
        await PokemonLocalRepository.shared.fetchPokedex()
    }

    func getRemotePokedexIfAvailable() async throws -> PokedexEntity? {
        let URLRequest = API.Backend.PokemonAPI.pokedex.urlRequest
        guard let pokedex: PokedexEntity = try await APIClient.request(URLRequest) else {
            return nil
        }
        await storePokemon(pokedex)
        return pokedex
    }

    @MainActor
    func storePokemon(_ pokedex: PokedexEntity) {
        let pokemonLocalItems = PokemonInfoModelMapper.mapList(pokedex.pokemon)
        pokemonLocalItems.forEach { PokemonLocalRepository.shared.appendPokemon(pokemon: $0) }
    }
}
