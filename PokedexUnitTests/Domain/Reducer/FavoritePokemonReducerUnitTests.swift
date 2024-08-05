//
//  FavoritePokemonReducerUnitTests.swift
//  PokedexUnitTests
//
//  Created by Jordi Gamez on 22/5/24.
//

import ComposableArchitecture
import XCTest
@testable import Pokedex

final class FavoritePokemonReducerUnitTests: XCTestCase {

    private static let timeout: Duration = .seconds(1)

    @MainActor
    func testLoadFavoritePokemonNotFound() async throws {
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.favoritePokemon = nil

        let store = buildStore(pokemonFavoriteRepository: pokemonFavoriteRepository)

        await store.send(.loadPokemon)

        await store.receive(.emptyFavoriteList, timeout: Self.timeout) { state in
            state.screen = .empty
            state.pokemon = []
        }
    }

    @MainActor
    func testLoadFavoritePokemonEmpty() async throws {
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.favoritePokemon = [.empty()]

        let store = buildStore(pokemonFavoriteRepository: pokemonFavoriteRepository)

        await store.send(.loadPokemon)

        await store.receive(.emptyFavoriteList, timeout: Self.timeout) { state in
            state.screen = .empty
            state.pokemon = []
        }
    }

    @MainActor
    func testLoadFavoritePokemonContent() async throws {
        let pokemonDetail: [PokemonDetail] = [.mock()]
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.favoritePokemon = [.mock()]

        let store = buildStore(pokemonFavoriteRepository: pokemonFavoriteRepository)

        await store.send(.loadPokemon)

        await store.receive(.favoriteListLoaded(pokemonDetail), timeout: Self.timeout) { state in
            state.screen = .content
            state.pokemon = pokemonDetail
        }
    }

    @MainActor
    func testRetryLoadFavoritePokemonNotFound() async throws {
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.favoritePokemon = nil

        let store = buildStore(pokemonFavoriteRepository: pokemonFavoriteRepository, screenState: .error)

        await store.send(.retryLoadFavoritePokemon) { state in
            state.screen = .loading
        }

        await store.receive(.emptyFavoriteList, timeout: Self.timeout) { state in
            state.screen = .empty
            state.pokemon = []
        }
    }

    @MainActor
    func testRetryLoadFavoritePokemonEmpty() async throws {
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.favoritePokemon = [.empty()]

        let store = buildStore(pokemonFavoriteRepository: pokemonFavoriteRepository, screenState: .error)

        await store.send(.retryLoadFavoritePokemon) { state in
            state.screen = .loading
        }

        await store.receive(.emptyFavoriteList, timeout: Self.timeout) { state in
            state.screen = .empty
            state.pokemon = []
        }
    }
}

private extension FavoritePokemonReducerUnitTests {

    func buildPokemonFavoriteRepository() -> MockPokemonFavoriteRepository {
        MockPokemonFavoriteRepository()
    }

    func buildStore(
        pokemonFavoriteRepository: PokemonFavoriteRepositoryProtocol,
        screenState: FavoritePokemonReducer.ScreenState = .loading,
        pokemonDetail: PokemonDetail? = nil,
        isFavorite: Bool = false
    ) -> TestStore<FavoritePokemonReducer.State, FavoritePokemonReducer.Action> {
        TestStore(
            initialState: FavoritePokemonReducer.State(screen: screenState)
        ) {
            FavoritePokemonReducer()
        } withDependencies: {
            $0.pokemonFavoriteRepository = pokemonFavoriteRepository
        }
    }
}
