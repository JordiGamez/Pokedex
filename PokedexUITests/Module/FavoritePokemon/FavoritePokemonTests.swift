//
//  FavoritePokemonTests.swift
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

final class FavoritePokemonTests: XCTestCase {

    func testFavoritePokemonLoadingScreenLightMode() throws {
        let state = buildState(screenState: .loading)
        let store = buildReducer(state: state)
        let view = FavoritePokemonPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        FavoritePokemonUIGroup.screenshots(viewController, name: "FavoritePokemonLoadingScreen", scheme: .light)
    }

    func testFavoritePokemonLoadingScreenDarkMode() throws {
        let state = buildState(screenState: .loading)
        let store = buildReducer(state: state)
        let view = FavoritePokemonPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        FavoritePokemonUIGroup.screenshots(viewController, name: "FavoritePokemonLoadingScreen", scheme: .dark)
    }

    func testFavoritePokemonEmptyScreenLightMode() throws {
        let state = buildState(screenState: .empty)
        let store = buildReducer(state: state)
        let view = FavoritePokemonPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        FavoritePokemonUIGroup.screenshots(viewController, name: "FavoritePokemonEmptyScreen", scheme: .light)
    }

    func testFavoritePokemonEmptyScreenDarkMode() throws {
        let state = buildState(screenState: .empty)
        let store = buildReducer(state: state)
        let view = FavoritePokemonPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        FavoritePokemonUIGroup.screenshots(viewController, name: "FavoritePokemonEmptyScreen", scheme: .dark)
    }

    func testFavoritePokemonErrorScreenLightMode() throws {
        let state = buildState(screenState: .error)
        let store = buildReducer(state: state)
        let view = FavoritePokemonPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        FavoritePokemonUIGroup.screenshots(viewController, name: "FavoritePokemonErrorScreen", scheme: .light)
    }

    func testFavoritePokemonErrorScreenDarkMode() throws {
        let state = buildState(screenState: .error)
        let store = buildReducer(state: state)
        let view = FavoritePokemonPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        FavoritePokemonUIGroup.screenshots(viewController, name: "FavoritePokemonErrorScreen", scheme: .dark)
    }

    func testFavoritePokemonContentScreenLightMode() throws {
        let state = buildState(screenState: .content, pokemon: PokemonDetail.mockList())
        let store = buildReducer(state: state)
        let view = FavoritePokemonPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        FavoritePokemonUIGroup.screenshots(viewController, name: "FavoritePokemonContentScreen", scheme: .light)
    }

    func testFavoritePokemonContentScreenDarkMode() throws {
        let state = buildState(screenState: .content, pokemon: PokemonDetail.mockList())
        let store = buildReducer(state: state)
        let view = FavoritePokemonPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        FavoritePokemonUIGroup.screenshots(viewController, name: "FavoritePokemonContentScreen", scheme: .dark)
    }
}

private extension FavoritePokemonTests {

    func buildState(
        screenState: FavoritePokemonReducer.ScreenState,
        pokemon: [PokemonDetail] = []
    ) -> FavoritePokemonReducer.State {
        .init(
            screen: screenState,
            pokemon: pokemon
        )
    }

    func buildReducer(state: FavoritePokemonReducer.State) -> Store<FavoritePokemonReducer.State, FavoritePokemonReducer.Action> {
        .init(initialState: state) {
            FavoritePokemonReducer()
        }
    }
}
