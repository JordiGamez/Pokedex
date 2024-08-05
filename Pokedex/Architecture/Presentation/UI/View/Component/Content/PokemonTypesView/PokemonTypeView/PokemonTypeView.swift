//
//  PokemonTypeView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 8/5/24.
//

import SwiftUI
import DesignSystem

struct PokemonTypeView: View {
    
    @Environment(\.layoutDisplayType) private var layoutDisplayType

    @EnvironmentObject private var theme: ThemeManager

    private static let typeImageSize: CGFloat = 20
    private static let typeAppleTVImageSize: CGFloat = 40

    private let type: PokemonType

    private var imageSize: CGFloat {
        layoutDisplayType == .tv ? Self.typeAppleTVImageSize : Self.typeImageSize
    }

    init(type: PokemonType) {
        self.type = type
    }

    var body: some View {
        HStack {
            typeImage
            typeText
            Spacer()
        }
    }
}

private extension PokemonTypeView {

    var typeImage: some View {
        UIToolkit.image(
            name: type.name.rawValue,
            size: imageSize
        )
    }

    var typeText: some View {
        UIToolkit.text(
            type.name.rawValue.uppercased(),
            fontModel: theme.font.caption,
            color: theme.color.textPrimary
        )
        .fontWeight(.bold)
        .padding(.horizontal, theme.spacing.small)
    }
}

#Preview {
    PokemonTypeView(
        type: .init(
            slot: 1,
            name: .electric,
            url: ""
        )
    )
}
