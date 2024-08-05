//
//  PokedexInfoViewReducerUnitTests.swift
//  PokedexUnitTests
//
//  Created by Jordi Gamez on 21/5/24.
//

import ComposableArchitecture
import XCTest
@testable import Pokedex

final class PokedexInfoViewReducerUnitTests: XCTestCase {

    private static let timeout: Duration = .seconds(1)

    @MainActor
    func testLoadPokemonNotFound() async throws {
        var pokemonDetailRepository = buildPokemonDetailRepository()
        pokemonDetailRepository.pokemonDetail = nil

        let store = buildStore(pokemonDetailRepository: pokemonDetailRepository)

        await store.send(.loadPokemon)

        await store.receive(.pokemonDetailNotFound, timeout: Self.timeout)
    }

    @MainActor
    func testLoadPokemonContent() async throws {
        let pokemonDetailEntity: PokemonDetailEntity = .mock()
        let pokemonDetail: PokemonDetail = .mock()
        var pokemonDetailRepository = buildPokemonDetailRepository()
        pokemonDetailRepository.pokemonDetail = pokemonDetailEntity

        let store = buildStore(pokemonDetailRepository: pokemonDetailRepository)

        await store.send(.loadPokemon)

        await store.receive(.pokemonDetailLoaded(pokemonDetail), timeout: Self.timeout) { state in
            state.pokemonDetail = pokemonDetail
        }
    }
}

private extension PokedexInfoViewReducerUnitTests {

    func buildPokemonDetailRepository() -> MockPokemonDetailRepository {
        MockPokemonDetailRepository()
    }

    func buildStore(
        pokemonDetailRepository: MockPokemonDetailRepository,
        pokemonDetail: PokemonDetail? = nil
    ) -> TestStore<PokedexInfoViewReducer.State, PokedexInfoViewReducer.Action> {
        TestStore(initialState: PokedexInfoViewReducer.State(pokemonInfo: .mock(), pokemonDetail: pokemonDetail)) {
            PokedexInfoViewReducer()
        } withDependencies: {
            $0.pokemonDetailRepository = pokemonDetailRepository
        }
    }
}
