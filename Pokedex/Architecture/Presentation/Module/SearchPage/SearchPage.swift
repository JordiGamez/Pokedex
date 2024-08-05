//
//  SearchPage.swift
//  Pokedex
//
//  Created by Jordi Gamez on 3/8/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct SearchPage: View {

    @Environment(\.layoutDisplayType) var layoutDisplayType

    @EnvironmentObject private var theme: ThemeManager

    @State private var searchText = ""

    private let store: StoreOf<SearchReducer>

    init(store: StoreOf<SearchReducer>) {
        self.store = store
    }

    var body: some View {
        NavigationStack {
            view
                .if(layoutDisplayType != .tv, { view in
                    view
                        .toolbar { toolbar }
                        .toolbarStyle()
                })
                .searchable(text: $searchText)
        }
        .onFirstAppear(loadInitialData)
    }
}

private extension SearchPage {

    func loadInitialData() {
        store.send(.loadPokedex)
    }

    var toolbar: some ToolbarContent {
        LogoToolBarContent(logoImage: .logo)
    }

    @ViewBuilder
    var view: some View {
        Group {
            switch store.state.screen {
            case .loading:
                loadingView
            case .empty:
                emptyView
            case .error:
                errorView
            case .content:
                content
            }
        }
    }

    var loadingView: some View {
        LoadingView(loadingImage: .loading)
    }

    var emptyView: some View {
        PokedexEmptyView {
            store.send(.retryLoadPokedex)
        }
    }

    var errorView: some View {
        PokedexErrorView {
            store.send(.retryLoadPokedex)
        }
    }

    var content: some View {
        VStack {
            pokedex
        }
        .padding(.vertical, theme.spacing.medium)
        .background(theme.color.backgroundPrimary)
    }

    var pokedex: some View {
        ScrollView {
            pokemonList
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, theme.spacing.medium)
    }

    var pokemonList: some View {
        LazyVGrid(
            columns: LayoutManager.searchGridLayout,
            alignment: .center,
            spacing: theme.spacing.medium
        ) {
            pokemon
        }
    }

    var pokemon: some View {
        ForEach(store.pokemon.filter({ $0.name.uppercased().contains(searchText.uppercased()) || searchText.isEmpty }), id:\.number) { pokemonInfo in
            NavigationLink(destination: pokemonDetailPage(pokemonInfo: pokemonInfo)) {
                ViewManager.pokemonSearchView(
                    pokemonInfo: pokemonInfo
                )
                .environmentObject(theme)
            }
            #if os(iOS)
            .buttonStyle(EmptyButtonStyle())
            #else
            .buttonStyle(FocusButtonStyle())
            #endif
        }
    }

    func pokemonDetailPage(
        pokemonInfo: PokemonInfo
    ) -> some View {
        ViewManager.pokemonDetailPage(
            pokemonInfo: pokemonInfo
        )
        .environmentObject(theme)
    }
}

#Preview {
    SearchPage(store: .init(initialState: .init()) {
        SearchReducer()
    })
    .environmentObject(ThemeManager.main)
}
