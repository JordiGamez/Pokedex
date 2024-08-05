//
//  PokemonExtendedInfoView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 13/6/24.
//

import SwiftUI
import Charts
import ComposableArchitecture
import DesignSystem

struct PokemonExtendedInfoView: View {

    @Environment(\.layoutDisplayType) private var layoutDisplayType

    @EnvironmentObject private var theme: ThemeManager

    private static let pokemonImageSize: CGFloat = 150
    private static let pokemonAppleTVImageSize: CGFloat = 300

    private var itemPokemonImageSize: CGFloat {
        layoutDisplayType == .tv ? Self.pokemonAppleTVImageSize : Self.pokemonImageSize
    }

    private let pokemonDetail: PokemonDetail

    init(pokemonDetail: PokemonDetail) {
        self.pokemonDetail = pokemonDetail
    }

    var body: some View {
        HStack(spacing: .zero) {
            columnColor
            pokemonData
        }
    }
}

private extension PokemonExtendedInfoView {

    var columnColor: some View {
        pokemonBackgroundColor()
            .frame(width: 5)
    }

    var pokemonData: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: .zero) {
                pokemonImage
                pokemonStatsChart
            }
            .padding(theme.spacing.small)

            HStack(spacing: .zero) {
                pokemonInformation
                pokemonAttributes
            }
            .frame(minWidth: .zero, maxWidth: .infinity)
            .padding(.horizontal, theme.spacing.extraSmall)
            .padding(.top, theme.spacing.small)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.bottom, theme.spacing.medium)
        .background(theme.color.backgroundSecondary)
    }

    func pokemonBackgroundColor() -> some View {
        pokemonDetail.typeColor
    }

    var pokemonImage: some View {
        ZStack(alignment: .topLeading) {
            pokemonPicture(pokemonDetail.imageURL)
        }
        .clipped()
    }

    var pokemonStatsChart: some View {
        PokemonStatsChartView(
            stats: pokemonDetail.orderedStats,
            typeColor: pokemonDetail.typeColor
        )
    }

    var pokemonInformation: some View {
        VStack(alignment: .leading) {
            pokemonName(pokemonDetail.name)
            pokemonNumber(pokemonDetail.numberFormatted)
        }
        .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
    }

    func pokemonPicture(_ url: String) -> some View {
        HStack {
            Spacer()
            UIToolkit.asyncImage(
                url,
                size: itemPokemonImageSize,
                placeholderImage: .loading
            )
            Spacer()
        }
    }

    func pokemonName(_ name: String) -> some View {
        UIToolkit.text(
            name.uppercased(),
            fontModel: theme.font.body,
            color: theme.color.textPrimary
        )
        .fontWeight(.bold)
        .multilineTextAlignment(.leading)
        .padding(.horizontal, theme.spacing.medium)
    }

    func pokemonNumber(_ number: String) -> some View {
        UIToolkit.text(
            "#\(number)",
            fontModel: theme.font.caption,
            color: theme.color.textPrimary
        )
        .fontWeight(.semibold)
        .padding(.horizontal, theme.spacing.medium)
    }

    var pokemonAttributes: some View {
        PokemonAttributesView(
            height: pokemonDetail.height,
            weight: pokemonDetail.weight
        )
        .frame(minWidth: .zero, maxWidth: .infinity)
    }
}

#Preview {
    PokemonExtendedInfoView(
        pokemonDetail: .mock()
    )
    .environmentObject(ThemeManager.main)
}
