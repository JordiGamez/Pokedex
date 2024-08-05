//
//  PokedexPage.swift
//  Pokedex
//
//  Created by Jordi Gamez on 26/3/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct PokedexPage: View {

    @Environment(\.layoutDisplayType) var layoutDisplayType

    @EnvironmentObject private var theme: ThemeManager

    @State private var showFavoritePokemonPage = false

    private let store: StoreOf<PokedexReducer>

    init(store: StoreOf<PokedexReducer>) {
        self.store = store
    }

    var body: some View {
        NavigationStack {
            view
                .toolbar { toolbar }
                .toolbarStyle()
        }
        .onFirstAppear(loadInitialData)
    }
}

private extension PokedexPage {

    func loadInitialData() {
        store.send(.loadPokedex)
        store.send(.loadFavoritePokemon)
    }

    var toolbar: some ToolbarContent {
        ActionToolbarContent(
            logoImage: .logo,
            action: .favorite,
            didTapAction: { showFavoritePokemonPage = true }
        )
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
        .fullScreenCover(isPresented: $showFavoritePokemonPage) {
            favoritePokemonPage()
                .if(layoutDisplayType == .tv, { view in
                    view
                        .background(theme.color.backgroundSecondary)
                })
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
            columns: LayoutManager.blogGridLayout,
            alignment: .center,
            spacing: theme.spacing.medium
        ) {
            pokemon
        }
    }

    var pokemon: some View {
        ForEach(store.pokemon, id:\.number) { pokemonInfo in
            NavigationLink(destination: pokemonDetailPage(pokemonInfo: pokemonInfo)) {
                pokemonInfoView(pokemonInfo: pokemonInfo)
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

    func pokemonInfoView(
        pokemonInfo: PokemonInfo
    ) -> some View {
        ViewManager.pokemonInfoView(
            pokemonInfo: pokemonInfo
        )
        .environmentObject(theme)
    }

    func favoritePokemonPage() -> some View {
        ViewManager.favoritePokemonPage()
            .environmentObject(theme)
    }
}

#Preview {
    PokedexPage(store: .init(initialState: .init()) {
        PokedexReducer()
    })
    .environmentObject(ThemeManager.main)
}
