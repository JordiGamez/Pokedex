//
//  PokemonDetailRepository.swift
//  Pokedex
//
//  Created by Jordi Gamez on 18/6/24.
//

import Foundation
import ComposableArchitecture
import API

protocol PokemonDetailRepositoryProtocol {

    func getPokemonDetail(_ number: Int) async throws -> PokemonDetailEntity?
}

extension DependencyValues {

    var pokemonDetailRepository: PokemonDetailRepositoryProtocol {
        get { self[PokemonDetailRepositoryKey.self] }
        set { self[PokemonDetailRepositoryKey.self] = newValue }
    }
}

struct PokemonDetailRepositoryKey: DependencyKey {
    
    static var liveValue: PokemonDetailRepositoryProtocol = PokemonDetailRepository()
    static var testValue: PokemonDetailRepositoryProtocol = MockPokemonDetailRepository()
}

struct PokemonDetailRepository: PokemonDetailRepositoryProtocol {

    func getPokemonDetail(_ number: Int) async throws -> PokemonDetailEntity? {
        guard let pokemonDetail = await getLocalPokemonDetailIfAvailable(number) else {
            return try await getRemotePokemonDetailIfAvailable(number)
        }
        return PokemonDetailEntityMapper.map(pokemonDetail)
    }
}

private extension PokemonDetailRepository {

    func getLocalPokemonDetailIfAvailable(_ number: Int) async -> PokemonDetailModel? {
        guard let pokemonDetail = await PokemonLocalRepository.shared.fetchPokemonDetail(number: number)?.first else {
            return nil
        }
        return pokemonDetail
    }

    func getRemotePokemonDetailIfAvailable(_ number: Int) async throws -> PokemonDetailEntity? {
        let URLRequest = API.Backend.PokemonAPI.pokemon(id: number).urlRequest
        guard let pokemonDetail: PokemonDetailEntity = try await APIClient.request(URLRequest) else {
            return nil
        }
        await storePokemonDetail(pokemonDetail)
        return pokemonDetail
    }

    @MainActor
    func storePokemonDetail(_ pokemonDetail: PokemonDetailEntity) {
        guard let pokemonDetailLocalItem = PokemonDetailModelMapper.map(pokemonDetail) else {
            return
        }
        PokemonLocalRepository.shared.appendPokemonDetail(pokemonDetail: pokemonDetailLocalItem)
    }
}
