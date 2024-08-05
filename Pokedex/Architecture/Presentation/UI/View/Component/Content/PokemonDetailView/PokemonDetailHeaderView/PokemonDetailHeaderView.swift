//
//  PokemonDetailHeaderView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 14/6/24.
//

import SwiftUI
import DesignSystem

struct PokemonDetailHeaderView: View {

    @Environment(\.layoutDisplayType) private var layoutDisplayType
    @Environment(\.colorScheme) private var colorScheme

    @EnvironmentObject private var theme: ThemeManager

    private static let backButtonImageName: String = "arrow.left.circle.fill"
    private static let favoriteButtonImageName: String = "heart.circle.fill"
    private static let buttonSize: CGFloat = 30
    private static let pokemonImageSize: CGFloat = 200
    private static let pokemonAppleTVImageSize: CGFloat = 300
    private static let headerBackgroundImageName: String = "pokeball"
    private static let headerBackgroundScale: CGFloat = 2
    private static let headerAppleTVBackgroundScale: CGFloat = 3
    private static let headerBackgroundOpacity: CGFloat = 0.07
    private static let statsHeaderText: String = "Stats"

    private var imageSize: CGFloat {
        layoutDisplayType == .tv ? Self.pokemonAppleTVImageSize : Self.pokemonImageSize
    }

    private var headerScale: CGFloat {
        layoutDisplayType == .tv ? Self.headerAppleTVBackgroundScale : Self.headerBackgroundScale
    }

    private var pokemonDataColor: Color {
        guard pokemonDetail.types.first(where: { $0.slot == 1 })?.name != .dark else {
            return colorScheme == .dark ? theme.color.textPrimary: theme.color.textSecondary
        }
        return colorScheme == .dark ? theme.color.textSecondary : theme.color.textPrimary
    }

    private let pokemonDetail: PokemonDetail

    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }

    var body: some View {
        headerView
            .background(pokemonDetail.typeColor)
    }
}

private extension PokemonDetailHeaderView {

    var headerView: some View {
        VStack(spacing: .zero) {
            subheader
        }
        .padding()
        .background(headerBackground)
    }

    var subheader: some View {
        HStack(alignment: .center, spacing: .zero) {
            pokemonImage
            pokemonData
        }
        .frame(minWidth: .zero, maxWidth: .infinity)
    }

    var pokemonImage: some View {
        UIToolkit.asyncImage(
            pokemonDetail.imageURL,
            size: imageSize,
            placeholderImage: .loading
        )
        .frame(minWidth: .zero, maxWidth: .infinity)
    }

    var pokemonData: some View {
        VStack(alignment: .leading) {
            pokemonName
            pokemonNumber
            pokemonTypes
        }
        .frame(minWidth: .zero, maxWidth: .infinity)
    }

    var pokemonName: some View {
        UIToolkit.text(
            pokemonDetail.name.uppercased(),
            fontModel: theme.font.headline,
            color: pokemonDataColor
        )
        .fontWeight(.bold)
    }

    var pokemonNumber: some View {
        UIToolkit.text(
            "#\(pokemonDetail.numberFormatted)",
            fontModel: theme.font.caption,
            color: pokemonDataColor
        )
        .fontWeight(.semibold)
    }
    
    var pokemonTypes: some View {
        PokemonTypesView(
            types: pokemonDetail.types.sorted(by: { first, second in first.slot < second.slot })
        )
        .padding(.top, theme.spacing.medium)
    }

    var pokemonStats: some View {
        PokemonStatsView(
            stats: pokemonDetail.stats.sorted(by: { first, second in first.slot < second.slot }),
            color: pokemonDetail.typeColor
        )
    }

    var headerBackground: some View {
        UIToolkit.image(name: Self.headerBackgroundImageName)
            .scaleEffect(headerScale, anchor: .center)
            .opacity(Self.headerBackgroundOpacity)
    }
}

#Preview {
    PokemonDetailHeaderView(
        pokemonDetail: .mock()
    )
    .environmentObject(ThemeManager.main)
}
