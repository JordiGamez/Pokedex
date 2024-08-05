//
//  PokemonDetailTests.swift
//  PokedexUITests
//
//  Created by Jordi Gamez on 17/5/24.
//

import XCTest
import SwiftUI
import ComposableArchitecture
import SnapshotTesting
import DesignSystem
@testable import Pokedex

final class PokemonDetailTests: XCTestCase {

    func testPokemonDetailNoFavoriteScreenLightMode() throws {
        let pokemonInfo = PokemonInfo.mock()
        let pokemonDetail = PokemonDetail.mock()
        let state = buildState(pokemonInfo: pokemonInfo, pokemonDetail: pokemonDetail, isFavorite: false)
        let store = buildReducer(state: state)
        let view = PokemonDetailPage(store: store, pokemonInfo: pokemonInfo).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokemonDetailUIGroup.screenshots(viewController, name: "PokemonDetailNoFavoriteScreen", scheme: .light)
    }

    func testPokemonDetailNoFavoriteScreenDarkMode() throws {
        let pokemonInfo = PokemonInfo.mock()
        let pokemonDetail = PokemonDetail.mock()
        let state = buildState(pokemonInfo: pokemonInfo, pokemonDetail: pokemonDetail, isFavorite: false)
        let store = buildReducer(state: state)
        let view = PokemonDetailPage(store: store, pokemonInfo: pokemonInfo).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokemonDetailUIGroup.screenshots(viewController, name: "PokemonDetailNoFavoriteScreen", scheme: .dark)
    }

    func testPokemonDetailYesFavoriteScreenLightMode() throws {
        let pokemonInfo = PokemonInfo.mock()
        let pokemonDetail = PokemonDetail.mock()
        let state = buildState(pokemonInfo: pokemonInfo, pokemonDetail: pokemonDetail, isFavorite: true)
        let store = buildReducer(state: state)
        let view = PokemonDetailPage(store: store, pokemonInfo: pokemonInfo).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokemonDetailUIGroup.screenshots(viewController, name: "PokemonDetailYesFavoriteScreen", scheme: .light)
    }

    func testPokemonDetailYesFavoriteScreenDarkMode() throws {
        let pokemonInfo = PokemonInfo.mock()
        let pokemonDetail = PokemonDetail.mock()
        let state = buildState(pokemonInfo: pokemonInfo, pokemonDetail: pokemonDetail, isFavorite: true)
        let store = buildReducer(state: state)
        let view = PokemonDetailPage(store: store, pokemonInfo: pokemonInfo).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokemonDetailUIGroup.screenshots(viewController, name: "PokemonDetailYesFavoriteScreen", scheme: .dark)
    }
}

private extension PokemonDetailTests {

    func buildState(
        pokemonInfo: PokemonInfo,
        pokemonDetail: PokemonDetail,
        pokemon: [PokemonInfo] = [],
        isFavorite: Bool
    ) -> PokemonDetailReducer.State {
        .init(
            pokemonInfo: pokemonInfo,
            pokemonDetail: pokemonDetail,
            isFavorite: isFavorite
        )
    }

    func buildReducer(state: PokemonDetailReducer.State) -> Store<PokemonDetailReducer.State, PokemonDetailReducer.Action> {
        .init(initialState: state) {
            PokemonDetailReducer()
        }
    }
}
