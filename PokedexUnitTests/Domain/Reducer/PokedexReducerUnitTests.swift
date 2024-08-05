//
//  PokedexReducerUnitTests.swift
//  PokedexUnitTests
//
//  Created by Jordi Gamez on 17/5/24.
//

import ComposableArchitecture
import XCTest
@testable import Pokedex

final class PokedexReducerUnitTests: XCTestCase {

    private static let timeout: Duration = .seconds(1)

    @MainActor
    func testLoadPokedexNotFound() async throws {
        var pokemonRepository = buildPokedexRepository()
        pokemonRepository.pokedex = nil
        let pokemonFavoriteRepository = buildPokemonFavoriteRepository()

        let store = buildStore(
            pokemonRepository: pokemonRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository
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
        let pokemonFavoriteRepository = buildPokemonFavoriteRepository()

        let store = buildStore(
            pokemonRepository: pokemonRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository
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
        let pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        let pokemonInfo: PokemonInfo = .mock()

        let store = buildStore(
            pokemonRepository: pokemonRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository
        )

        await store.send(.loadPokedex)

        await store.receive(.pokedexLoaded([pokemonInfo]), timeout: Self.timeout) { state in
            state.screen = .content
            state.pokemon = [pokemonInfo]
        }
    }

    @MainActor
    func testLoadFavoritePokemonNotFound() async throws {
        let pokemonRepository = buildPokedexRepository()
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.favoritePokemon = nil

        let store = buildStore(
            pokemonRepository: pokemonRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository,
            favoritePokemon: [.mock()]
        )

        await store.send(.loadFavoritePokemon)

        await store.receive(.emptyFavoriteList, timeout: Self.timeout) { state in
            state.favoritePokemon = []
        }
    }
    
    @MainActor
    func testLoadFavoritePokemonEmpty() async throws {
        let pokemonRepository = buildPokedexRepository()
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.favoritePokemon = [.empty()]

        let store = buildStore(
            pokemonRepository: pokemonRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository,
            favoritePokemon: [.mock()]
        )

        await store.send(.loadFavoritePokemon)

        await store.receive(.emptyFavoriteList, timeout: Self.timeout) { state in
            state.favoritePokemon = []
        }
    }

    @MainActor
    func testLoadFavoritePokemonContent() async throws {
        let pokemonRepository = buildPokedexRepository()
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.favoritePokemon = [.mock()]
        let pokemonDetail: PokemonDetail = .mock()

        let store = buildStore(
            pokemonRepository: pokemonRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository
        )

        await store.send(.loadFavoritePokemon)

        await store.receive(.favoriteListLoaded([pokemonDetail]), timeout: Self.timeout) { state in
            state.favoritePokemon = [pokemonDetail]
        }
    }

    @MainActor
    func testRetryLoadPokedexNotFound() async throws {
        var pokemonRepository = buildPokedexRepository()
        pokemonRepository.pokedex = nil
        let pokemonFavoriteRepository = buildPokemonFavoriteRepository()

        let store = buildStore(
            pokemonRepository: pokemonRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository
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
        let pokemonFavoriteRepository = buildPokemonFavoriteRepository()

        let store = buildStore(
            pokemonRepository: pokemonRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository
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
        let pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        let pokemonInfo: PokemonInfo = .mock()

        let store = buildStore(
            pokemonRepository: pokemonRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository
        )

        await store.send(.retryLoadPokedex)

        await store.receive(.pokedexLoaded([pokemonInfo]), timeout: Self.timeout) { state in
            state.screen = .content
            state.pokemon = [pokemonInfo]
        }
    }
}

private extension PokedexReducerUnitTests {

    func buildPokedexRepository() -> MockPokedexRepository {
        MockPokedexRepository()
    }

    func buildPokemonFavoriteRepository() -> MockPokemonFavoriteRepository {
        MockPokemonFavoriteRepository()
    }

    func buildStore(
        pokemonRepository: PokedexRepositoryProtocol,
        pokemonFavoriteRepository: PokemonFavoriteRepositoryProtocol,
        favoritePokemon: [PokemonDetail] = []
    ) -> TestStore<PokedexReducer.State, PokedexReducer.Action> {
        TestStore(initialState: PokedexReducer.State(favoritePokemon: favoritePokemon)) {
            PokedexReducer()
        } withDependencies: {
            $0.pokedexRepository = pokemonRepository
            $0.pokemonFavoriteRepository = pokemonFavoriteRepository
        }
    }
}
