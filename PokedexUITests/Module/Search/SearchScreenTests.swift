//
//  SearchScreenTests.swift
//  PokedexUITests
//
//  Created by Jordi Gamez on 4/8/24.
//

import XCTest
import SwiftUI
import ComposableArchitecture
import SnapshotTesting
import DesignSystem
@testable import Pokedex

final class SearchScreenTests: XCTestCase {

    func testSearchLoadingScreenLightMode() throws {
        let state = buildState(screenState: .loading)
        let store = buildReducer(state: state)
        let view = SearchPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        SearchUIGroup.screenshots(viewController, name: "SearchLoadingScreen", scheme: .light)
    }

    func testSearchLoadingScreenDarkMode() throws {
        let state = buildState(screenState: .loading)
        let store = buildReducer(state: state)
        let view = SearchPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        SearchUIGroup.screenshots(viewController, name: "SearchLoadingScreen", scheme: .dark)
    }

    func testSearchEmptyScreenLightMode() throws {
        let state = buildState(screenState: .empty)
        let store = buildReducer(state: state)
        let view = SearchPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        SearchUIGroup.screenshots(viewController, name: "SearchEmptyScreen", scheme: .light)
    }

    func testSearchEmptyScreenDarkMode() throws {
        let state = buildState(screenState: .empty)
        let store = buildReducer(state: state)
        let view = SearchPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        SearchUIGroup.screenshots(viewController, name: "SearchEmptyScreen", scheme: .dark)
    }

    func testSearchErrorScreenLightMode() throws {
        let state = buildState(screenState: .error)
        let store = buildReducer(state: state)
        let view = SearchPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        SearchUIGroup.screenshots(viewController, name: "SearchErrorScreen", scheme: .light)
    }

    func testSearchErrorScreenDarkMode() throws {
        let state = buildState(screenState: .error)
        let store = buildReducer(state: state)
        let view = SearchPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        SearchUIGroup.screenshots(viewController, name: "SearchErrorScreen", scheme: .dark)
    }

    func testSearchContentScreenLightMode() throws {
        let state = buildState(screenState: .content, pokemon: PokemonInfo.mockList())
        let store = buildReducer(state: state)
        let view = SearchPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        SearchUIGroup.screenshots(viewController, name: "SearchContentScreen", scheme: .light)
    }

    func testSearchContentScreenDarkMode() throws {
        let state = buildState(screenState: .content, pokemon: PokemonInfo.mockList())
        let store = buildReducer(state: state)
        let view = SearchPage(store: store).environmentObject(ThemeManager.main)
        let viewController = UIHostingController(rootView: view)
        SearchUIGroup.screenshots(viewController, name: "SearchContentScreen", scheme: .dark)
    }
}

private extension SearchScreenTests {

    func buildState(
        screenState: SearchReducer.ScreenState,
        pokemon: [PokemonInfo] = []
    ) -> SearchReducer.State {
        .init(
            screen: screenState,
            pokemon: pokemon
        )
    }

    func buildReducer(state: SearchReducer.State) -> Store<SearchReducer.State, SearchReducer.Action> {
        .init(initialState: state) {
            SearchReducer()
        }
    }
}
