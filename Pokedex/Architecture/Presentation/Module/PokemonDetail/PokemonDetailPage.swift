//
//  PokemonDetailPage.swift
//  Pokedex
//
//  Created by Jordi Gamez on 4/5/24.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

struct PokemonDetailPage: View {

    @Environment(\.layoutDisplayType) private var layoutDisplayType
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject private var theme: ThemeManager

    private static let backButtonImageName: String = "arrow.left.circle.fill"
    private static let favoriteButtonImageName: String = "heart.circle.fill"

    private let store: StoreOf<PokemonDetailReducer>
    private let pokemonInfo: PokemonInfo

    init(
        store: StoreOf<PokemonDetailReducer>,
        pokemonInfo: PokemonInfo
    ) {
        self.store = store
        self.pokemonInfo = pokemonInfo
    }

    var body: some View {
        NavigationStack {
            detailView
                .toolbar { toolbar }
                .toolbarStyle()
        }
        .onFirstAppear(loadInitialData)
    }
}

private extension PokemonDetailPage {

    func loadInitialData() {
        store.send(.loadPokemonDetail)
    }

    var toolbar: some ToolbarContent {
        NavigationWithActionToolbarContent(
            isActionSelected: store.state.isFavorite,
            backButtonImageName: Self.backButtonImageName,
            actionButtonImageName: Self.favoriteButtonImageName,
            didTapBack: {
                dismiss()
            },
            didTapAction: {
                store.send(.favorite)
            }
        )
    }

    @ViewBuilder
    var detailView: some View {
        if let pokemonDetail = store.state.pokemonDetail {
            PokemonDetailView(pokemonDetail: pokemonDetail)
        }
    }
}

#Preview {
    PokemonDetailPage(
        store: .init(initialState: .init(isFavorite: false)) {
            PokemonDetailReducer()
        },
        pokemonInfo: .mock()
    )
    .environmentObject(ThemeManager.main)
}
