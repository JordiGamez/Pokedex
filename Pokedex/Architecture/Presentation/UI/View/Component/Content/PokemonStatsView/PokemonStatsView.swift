//
//  PokemonStatsView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 8/5/24.
//

import SwiftUI
import DesignSystem

struct PokemonStatsView: View {

    @Environment(\.layoutDisplayType) private var layoutDisplayType

    @EnvironmentObject private var theme: ThemeManager

    private let stats: [PokemonStat]
    private let color: Color

    private var bottomPadding: CGFloat {
        layoutDisplayType == .tv ? theme.spacing.extraLarge : theme.spacing.medium
    }

    init(
        stats: [PokemonStat],
        color: Color
    ) {
        self.stats = stats
        self.color = color
    }

    var body: some View {
        VStack(spacing: .zero) {
            content
        }
    }
}

private extension PokemonStatsView {

    var content: some View {
        ForEach(stats, id: \.self) { stat in
            statView(stat)
        }
    }

    func statView(_ stat: PokemonStat) -> some View {
        PokemonStatView(
            stat: stat,
            color: color
        )
        .padding()
        .background(theme.color.backgroundSecondary)
        .clipShape(RoundedRectangle(cornerRadius: theme.radius.medium))
        .padding(.bottom, bottomPadding)
    }
}

#Preview {
    PokemonStatsView(
        stats: [],
        color: .yellow
    )
}
