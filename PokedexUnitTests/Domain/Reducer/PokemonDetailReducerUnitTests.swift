//
//  PokemonDetailReducerUnitTests.swift
//  PokedexUnitTests
//
//  Created by Jordi Gamez on 22/5/24.
//

import ComposableArchitecture
import XCTest
@testable import Pokedex

final class PokemonDetailReducerUnitTests: XCTestCase {

    private static let timeout: Duration = .seconds(2)

    @MainActor
    func testLoadPokemonDetailNoInfo() async throws {
        let pokemonDetail: PokemonDetail = .mock()
        var pokemonDetailRepository = buildPokemonDetailRepository()
        pokemonDetailRepository.pokemonDetail = nil
        let pokemonFavoriteRepository = buildPokemonFavoriteRepository()

        let store = buildStore(
            pokemonDetailRepository: pokemonDetailRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository,
            pokemonInfo: nil,
            pokemonDetail: pokemonDetail
        )

        await store.send(.loadPokemonDetail)
    }

    @MainActor
    func testLoadPokemonDetailLoaded() async throws {
        let isFavorite = true
        let pokemonDetailEntity: PokemonDetailEntity = .mock()
        let pokemonDetail: PokemonDetail = .mock()
        var pokemonDetailRepository = buildPokemonDetailRepository()
        pokemonDetailRepository.pokemonDetail = pokemonDetailEntity
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.isFavorite = isFavorite

        let store = buildStore(
            pokemonDetailRepository: pokemonDetailRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository
        )

        await store.send(.loadPokemonDetail)

        await store.receive(.pokemonDetailLoaded(pokemonDetail), timeout: Self.timeout) { state in
            state.pokemonDetail = pokemonDetail
        }

        await store.receive(.pokemonFavoriteStatusChanged(isFavorite), timeout: Self.timeout) { state in
            state.isFavorite = isFavorite
        }
    }

    @MainActor
    func testAddToFavoriteNoInfo() async throws {
        let pokemonDetail: PokemonDetail = .mock()
        var pokemonDetailRepository = buildPokemonDetailRepository()
        pokemonDetailRepository.pokemonDetail = nil
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.isFavorite = true

        let store = buildStore(
            pokemonDetailRepository: pokemonDetailRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository,
            pokemonInfo: nil,
            pokemonDetail: pokemonDetail,
            isFavorite: false
        )

        await store.send(.favorite)
    }

    @MainActor
    func testAddToFavorite() async throws {
        let pokemonDetail: PokemonDetail = .mock()
        var pokemonDetailRepository = buildPokemonDetailRepository()
        pokemonDetailRepository.pokemonDetail = nil
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.isFavorite = true

        let store = buildStore(
            pokemonDetailRepository: pokemonDetailRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository,
            pokemonDetail: pokemonDetail,
            isFavorite: false
        )

        await store.send(.favorite)

        await store.receive(.pokemonFavoriteStatusChanged(true), timeout: Self.timeout) { state in
            state.isFavorite = true
        }
    }

    @MainActor
    func testRemoveFromFavorite() async throws {
        let pokemonDetail: PokemonDetail = .mock()
        var pokemonDetailRepository = buildPokemonDetailRepository()
        pokemonDetailRepository.pokemonDetail = nil
        var pokemonFavoriteRepository = buildPokemonFavoriteRepository()
        pokemonFavoriteRepository.isFavorite = false

        let store = buildStore(
            pokemonDetailRepository: pokemonDetailRepository,
            pokemonFavoriteRepository: pokemonFavoriteRepository,
            pokemonDetail: pokemonDetail,
            isFavorite: true
        )

        await store.send(.favorite)

        await store.receive(.pokemonFavoriteStatusChanged(false), timeout: Self.timeout) { state in
            state.isFavorite = false
        }
    }
}

private extension PokemonDetailReducerUnitTests {

    func buildPokemonDetailRepository() -> MockPokemonDetailRepository {
        MockPokemonDetailRepository()
    }

    func buildPokemonFavoriteRepository() -> MockPokemonFavoriteRepository {
        MockPokemonFavoriteRepository()
    }

    func buildStore(
        pokemonDetailRepository: PokemonDetailRepositoryProtocol,
        pokemonFavoriteRepository: PokemonFavoriteRepositoryProtocol,
        pokemonInfo: PokemonInfo? = .mock(),
        pokemonDetail: PokemonDetail? = nil,
        isFavorite: Bool = false
    ) -> TestStore<PokemonDetailReducer.State, PokemonDetailReducer.Action> {
        TestStore(
            initialState: PokemonDetailReducer.State(
                pokemonInfo: pokemonInfo,
                pokemonDetail: pokemonDetail,
                isFavorite: isFavorite
            )
        ) {
            PokemonDetailReducer()
        } withDependencies: {
            $0.pokemonDetailRepository = pokemonDetailRepository
            $0.pokemonFavoriteRepository = pokemonFavoriteRepository
        }
    }
}
