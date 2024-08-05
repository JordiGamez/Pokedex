//
//  PokemonStatView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 8/5/24.
//

import SwiftUI
import DesignSystem

struct PokemonStatView: View {

    @Environment(\.layoutDisplayType) private var layoutDisplayType

    @EnvironmentObject private var theme: ThemeManager

    @State private var progress: CGFloat = 0

    private static let progressViewMaxValue: CGFloat = 200
    private static let progressViewIncreaseValue: CGFloat = 0.5
    private static let progressViewBarHeight: CGFloat = 10
    private static let progressViewAppleTVBarHeight: CGFloat = 40
    private static let progressViewValueWidth: CGFloat = 60
    private static let progressViewAppleValueWidth: CGFloat = 180
    private static let progressViewTextSize: CGFloat = 14
    private static let progressViewAppleTVTextSize: CGFloat = 28

    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    private let stat: PokemonStat
    private let color: Color

    private var progressBarTextSize: CGFloat {
        layoutDisplayType == .tv ? Self.progressViewAppleTVTextSize : Self.progressViewTextSize
    }

    private var progressBarHeight: CGFloat {
        layoutDisplayType == .tv ? Self.progressViewAppleTVBarHeight : Self.progressViewBarHeight
    }

    private var progressValueWidth: CGFloat {
        layoutDisplayType == .tv ? Self.progressViewAppleValueWidth : Self.progressViewValueWidth
    }

    init(stat: PokemonStat, color: Color) {
        self.stat = stat
        self.color = color
    }

    var body: some View {
        HStack(alignment: .center, spacing: theme.spacing.large) {
            statProgressView
            statValue
        }
        .focusable()
    }
}

private extension PokemonStatView {

    var statProgressView: some View {
        ProgressView(
            stat.nameFormated.uppercased(),
            value: progress,
            total: Self.progressViewMaxValue
        )
        .onReceive(timer) { _ in
            if progress < CGFloat(stat.value) {
                progress += Self.progressViewIncreaseValue
            }
        }
        .progressViewStyle(
            BarProgressViewStyle(
                color: color,
                backgroundColor: theme.color.backgroundPrimary,
                height: progressBarHeight,
                textSize: progressBarTextSize
            )
        )
        .tint(color)
        .foregroundStyle(theme.color.textPrimary)
    }

    var statValue: some View {
        UIToolkit.text(
            String(format: "%.f", Double(progress)),
            fontModel: theme.font.title,
            color: theme.color.textPrimary
        )
        .fontWeight(.bold)
        .frame(width: progressValueWidth)
    }
}

#Preview {
    PokemonStatView(
        stat: .init(
            slot: 1,
            name: "HP",
            value: 100
        ),
        color: .yellow
    )
}
