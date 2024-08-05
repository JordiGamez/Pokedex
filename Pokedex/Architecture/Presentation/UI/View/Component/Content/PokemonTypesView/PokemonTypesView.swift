//
//  PokemonTypesView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 8/5/24.
//

import SwiftUI
import DesignSystem

struct PokemonTypesView: View {

    @EnvironmentObject private var theme: ThemeManager

    private let types: [PokemonType]

    init(types: [PokemonType]) {
        self.types = types
    }

    var body: some View {
        VStack {
            content
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}

private extension PokemonTypesView {

    var content: some View {
        ForEach(types, id: \.self) { type in
            typeView(type)
        }
    }

    func typeView(_ type: PokemonType) -> some View {
        PokemonTypeView(type: type)
            .padding(theme.spacing.small)
            .frame(maxWidth: .infinity)
            .background(theme.color.backgroundSecondary)
            .clipShape(RoundedRectangle(cornerRadius: theme.spacing.medium))
    }
}

#Preview {
    PokemonTypesView(types: [.mock()])
}
