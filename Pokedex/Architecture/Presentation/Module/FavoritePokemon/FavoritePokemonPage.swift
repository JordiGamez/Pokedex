//
//  FavoritePokemonPage.swift
//  Pokedex
//
//  Created by Jordi Gamez on 14/5/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct FavoritePokemonPage: View {

    @Environment(\.layoutDisplayType) private var layoutDisplayType
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var theme: ThemeManager

    private static let customTitle: String = "Favorites"
    private static let backButtonImageName: String = "xmark.circle.fill"
    
    private let store: StoreOf<FavoritePokemonReducer>

    init(store: StoreOf<FavoritePokemonReducer>) {
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

private extension FavoritePokemonPage {

    func loadInitialData() {
        store.send(.loadPokemon)
        store.send(.listenForFavoriteChanges)
    }

    var toolbar: some ToolbarContent {
        NavigationWithTitleToolbarContent(
            title: Self.customTitle,
            subtitle: "(\(store.state.pokemon.count))",
            backButtonImageName: Self.backButtonImageName,
            didTapBack: { dismiss() }
        )
    }

    @ViewBuilder
    var view: some View {
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

    var loadingView: some View {
        LoadingView(loadingImage: .loading)
    }

    var emptyView: some View {
        PokedexEmptyView {
            store.send(.retryLoadFavoritePokemon)
        }
    }

    var errorView: some View {
        PokedexErrorView {
            store.send(.retryLoadFavoritePokemon)
        }
    }

    var content: some View {
        pokedex
            .padding(.top, theme.spacing.medium)
            .background(theme.color.backgroundPrimary)
            .onAppear {
                store.send(.reloadIfNeeded)
            }
    }

    var pokedex: some View {
        ScrollView {
            pokemonList
        }
        .frame(maxWidth: .infinity)
        .scrollIndicators(.hidden)
        .padding(.horizontal, theme.spacing.medium)
    }

    var pokemonList: some View {
        CustomGrid(
            alignment: .center,
            itemsCount: store.pokemon.count, 
            itemsPerRow: LayoutManager.favoriteGridLayout
        ) { number in
            pokemon(number)
        }
    }

    @ViewBuilder
    func pokemon(_ number: Int) -> some View {
        if store.pokemon.count > .zero {
            let pokemonDetail = store.pokemon[number]
            NavigationLink(destination: pokemonDetailPage(pokemonDetail)) {
                pokemonExtendedInfoView(pokemonDetail)
            }
            #if os(iOS)
            .buttonStyle(EmptyButtonStyle())
            #else
            .buttonStyle(FocusButtonStyle())
            #endif
        }
    }

    func pokemonDetailPage(_ pokemonDetail: PokemonDetail) -> some View {
        let pokemonInfo = PokemonInfo(
            number: pokemonDetail.number,
            name: pokemonDetail.name,
            url: pokemonDetail.imageURL
        )
        return ViewManager.pokemonDetailPage(pokemonInfo: pokemonInfo)
            .environmentObject(theme)
    }

    func pokemonExtendedInfoView(_ pokemonDetail: PokemonDetail) -> some View {
        ViewManager.pokemonExtendedInfoView(pokemonDetail: pokemonDetail)
            .environmentObject(theme)
    }
}

#Preview {
    FavoritePokemonPage(store: .init(initialState: .init(pokemon: PokemonDetail.mockList())) {
        FavoritePokemonReducer()
    })
    .environmentObject(ThemeManager.main)
}
