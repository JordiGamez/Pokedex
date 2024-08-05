//
//  PokemonStatsChartView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 19/6/24.
//

import SwiftUI
import Charts
import ComposableArchitecture
import DesignSystem

struct PokemonStatsChartView: View {

    @Environment(\.layoutDisplayType) private var layoutDisplayType

    @EnvironmentObject private var theme: ThemeManager

    private let stats: [PokemonStat]
    private let typeColor: Color

    init(
        stats: [PokemonStat],
        typeColor: Color
    ) {
        self.stats = stats
        self.typeColor = typeColor
    }

    var body: some View {
        ZStack {
            pieChart
            globalStatsScore
        }
    }
}

private extension PokemonStatsChartView {

    var pieChart: some View {
        Chart(stats, id: \.slot) { stat in
            SectorMark(
                angle: .value("Value", stat.value),
                innerRadius: .ratio(0.3),
                angularInset: 1
            )
            .foregroundStyle(by: .value("Name", stat.name))
            .cornerRadius(theme.spacing.extraSmall)
            .annotation(position: .overlay) {
                pieChartAnnotation(stat: stat)
            }
        }
        .chartLegend(.hidden)
        .chartForegroundStyleScale(range: pieChartColors(for: stats))
        .padding(theme.spacing.small)
    }

    func pieChartAnnotation(stat: PokemonStat) -> some View {
        VStack(spacing: .zero) {
            UIToolkit.text(
                stat.abbreviation,
                fontModel: theme.font.caption,
                color: theme.color.textPrimary
            )
            .fontWeight(.semibold)

            UIToolkit.text(
                "\(stat.value)",
                fontModel: theme.font.caption,
                color: theme.color.textPrimary
            )
        }
    }

    var globalStatsScore: some View {
        UIToolkit.text(
            "\(stats.map({$0.value}).reduce(0, +))",
            fontModel: theme.font.body,
            color: typeColor
        )
        .fontWeight(.bold)
        .brightness(-0.25)
    }

    func pieChartColors(for stats: [PokemonStat]) -> [Color] {
        var opacityChange: CGFloat = 1.0
        var statColorDictionary: [PokemonStat: Color] = [:]

        let bestStats = stats.sorted(by: { first, second in first.value > second.value })
        bestStats.forEach { stat in
            opacityChange -= 0.1
            statColorDictionary[stat] = typeColor.opacity(opacityChange)
        }
        let orderedStats = Array(statColorDictionary.sorted(by: { $0.0.slot < $1.0.slot }))
        let colors = orderedStats.map({ $0.value })

        return colors
    }
}

#Preview {
    PokemonStatsChartView(
        stats: [.mock()],
        typeColor: .typeElectric
    )
    .environmentObject(ThemeManager.main)
}
