//
//  PokedexScreenTests.swift
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

final class PokedexScreenTests: XCTestCase {

    func testPokedexLoadingScreenLightMode() throws {
        let state = buildState(screenState: .loading)
        let store = buildReducer(state: state)
        let view = PokedexPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokedexUIGroup.screenshots(viewController, name: "PokedexLoadingScreen", scheme: .light)
    }

    func testPokedexLoadingScreenDarkMode() throws {
        let state = buildState(screenState: .loading)
        let store = buildReducer(state: state)
        let view = PokedexPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokedexUIGroup.screenshots(viewController, name: "PokedexLoadingScreen", scheme: .dark)
    }

    func testPokedexEmptyScreenLightMode() throws {
        let state = buildState(screenState: .empty)
        let store = buildReducer(state: state)
        let view = PokedexPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokedexUIGroup.screenshots(viewController, name: "PokedexEmptyScreen", scheme: .light)
    }

    func testPokedexEmptyScreenDarkMode() throws {
        let state = buildState(screenState: .empty)
        let store = buildReducer(state: state)
        let view = PokedexPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokedexUIGroup.screenshots(viewController, name: "PokedexEmptyScreen", scheme: .dark)
    }

    func testPokedexErrorScreenLightMode() throws {
        let state = buildState(screenState: .error)
        let store = buildReducer(state: state)
        let view = PokedexPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokedexUIGroup.screenshots(viewController, name: "PokedexErrorScreen", scheme: .light)
    }

    func testPokedexErrorScreenDarkMode() throws {
        let state = buildState(screenState: .error)
        let store = buildReducer(state: state)
        let view = PokedexPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokedexUIGroup.screenshots(viewController, name: "PokedexErrorScreen", scheme: .dark)
    }

    func testPokedexContentScreenLightMode() throws {
        let state = buildState(screenState: .content, pokemon: PokemonInfo.mockList())
        let store = buildReducer(state: state)
        let view = PokedexPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokedexUIGroup.screenshots(viewController, name: "PokedexContentScreen", scheme: .light)
    }

    func testPokedexContentScreenDarkMode() throws {
        let state = buildState(screenState: .content, pokemon: PokemonInfo.mockList())
        let store = buildReducer(state: state)
        let view = PokedexPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        PokedexUIGroup.screenshots(viewController, name: "PokedexContentScreen", scheme: .dark)
    }
}

private extension PokedexScreenTests {

    func buildState(
        screenState: PokedexReducer.ScreenState,
        pokemon: [PokemonInfo] = []
    ) -> PokedexReducer.State {
        .init(
            screen: screenState,
            pokemon: pokemon
        )
    }

    func buildReducer(state: PokedexReducer.State) -> Store<PokedexReducer.State, PokedexReducer.Action> {
        .init(initialState: state) {
            PokedexReducer()
        }
    }
}
