//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 14/6/24.
//

import SwiftUI
import DesignSystem

struct PokemonDetailView: View {

    @EnvironmentObject private var theme: ThemeManager

    private let pokemonDetail: PokemonDetail

    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }

    var body: some View {
        detailView
            .background(pokemonDetail.typeColor)
    }
}

private extension PokemonDetailView {
    
    var detailView: some View {
        VStack(spacing: .zero) {
            PokemonDetailHeaderView(pokemonDetail: pokemonDetail)
            PokemonDetailContentView(pokemonDetail: pokemonDetail)
        }
    }
}

#Preview {
    PokemonDetailView(
        pokemonDetail: .mock()
    )
    .environmentObject(ThemeManager.main)
}
