//
//  PokemonDetailContentView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 14/6/24.
//

import SwiftUI
import DesignSystem

struct PokemonDetailContentView: View {

    @EnvironmentObject private var theme: ThemeManager

    private static let statsHeaderText: String = "Stats"

    private let pokemonDetail: PokemonDetail

    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }

    var body: some View {
        content
    }
}

private extension PokemonDetailContentView {

    var content: some View {
        ScrollView {
            VStack(alignment: .leading) {
                header
                pokemonStatsList
            }
            .padding()
        }
        .background(theme.color.backgroundPrimary)
    }

    var header: some View {
        UIToolkit.text(
            Self.statsHeaderText,
            fontModel: theme.font.title,
            color: theme.color.textPrimary
        )
    }

    var pokemonStatsList: some View {
        PokemonStatsView(
            stats: pokemonDetail.stats.sorted(by: { first, second in first.slot < second.slot }),
            color: pokemonDetail.typeColor
        )
    }
}

#Preview {
    PokemonDetailContentView(
        pokemonDetail: .mock()
    )
    .environmentObject(ThemeManager.main)
}
