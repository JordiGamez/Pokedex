//
//  SearchReducerUnitTests.swift
//  PokedexUnitTests
//
//  Created by Jordi Gamez on 4/8/24.
//

import ComposableArchitecture
import XCTest
@testable import Pokedex

final class SearchReducerUnitTests: XCTestCase {

    private static let timeout: Duration = .seconds(1)

    @MainActor
    func testLoadPokedexNotFound() async throws {
        var pokemonRepository = buildPokedexRepository()
        pokemonRepository.pokedex = nil

        let store = buildStore(
            pokemonRepository: pokemonRepository
        )

        await store.send(.loadPokedex)

        await store.receive(.pokedexNotFound, timeout: Self.timeout) { state in
            state.screen = .error
            state.pokemon = []
        }
    }

    @MainActor
    func testLoadPokedexEmpty() async throws {
        var pokemonRepository = buildPokedexRepository()
        pokemonRepository.pokedex = PokedexEntity(count: nil, pokemon: [])

        let store = buildStore(
            pokemonRepository: pokemonRepository
        )

        await store.send(.loadPokedex)

        await store.receive(.pokedexEmpty, timeout: Self.timeout) { state in
            state.screen = .empty
            state.pokemon = []
        }
    }

    @MainActor
    func testLoadPokedexContent() async throws {
        var pokemonRepository = buildPokedexRepository()
        pokemonRepository.pokedex = .mock()
        let pokemonInfo: PokemonInfo = .mock()

        let store = buildStore(
            pokemonRepository: pokemonRepository
        )

        await store.send(.loadPokedex)

        await store.receive(.pokedexLoaded([pokemonInfo]), timeout: Self.timeout) { state in
            state.screen = .content
            state.pokemon = [pokemonInfo]
        }
    }

    @MainActor
    func testRetryLoadPokedexNotFound() async throws {
        var pokemonRepository = buildPokedexRepository()
        pokemonRepository.pokedex = nil

        let store = buildStore(
            pokemonRepository: pokemonRepository
        )

        await store.send(.retryLoadPokedex)

        await store.receive(.pokedexNotFound, timeout: Self.timeout) { state in
            state.screen = .error
            state.pokemon = []
        }
    }

    @MainActor
    func testRetryLoadPokedexEmpty() async throws {
        var pokemonRepository = buildPokedexRepository()
        pokemonRepository.pokedex = PokedexEntity(count: nil, pokemon: [])

        let store = buildStore(
            pokemonRepository: pokemonRepository
        )

        await store.send(.retryLoadPokedex)

        await store.receive(.pokedexEmpty, timeout: Self.timeout) { state in
            state.screen = .empty
            state.pokemon = []
        }
    }

    @MainActor
    func testRetryLoadPokedexContent() async throws {
        var pokemonRepository = buildPokedexRepository()
        pokemonRepository.pokedex = .mock()
        let pokemonInfo: PokemonInfo = .mock()

        let store = buildStore(
            pokemonRepository: pokemonRepository
        )

        await store.send(.retryLoadPokedex)

        await store.receive(.pokedexLoaded([pokemonInfo]), timeout: Self.timeout) { state in
            state.screen = .content
            state.pokemon = [pokemonInfo]
        }
    }
}

private extension SearchReducerUnitTests {

    func buildPokedexRepository() -> MockPokedexRepository {
        MockPokedexRepository()
    }

    func buildStore(
        pokemonRepository: PokedexRepositoryProtocol
    ) -> TestStore<SearchReducer.State, SearchReducer.Action> {
        TestStore(initialState: SearchReducer.State()) {
            SearchReducer()
        } withDependencies: {
            $0.pokedexRepository = pokemonRepository
        }
    }
}
