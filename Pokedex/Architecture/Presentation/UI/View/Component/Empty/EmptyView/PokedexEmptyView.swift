//
//  PokedexEmpty.swift
//  Pokedex
//
//  Created by Jordi Gamez on 17/4/24.
//

import SwiftUI
import DesignSystem

struct PokedexEmptyView: View {

    let retry : () -> ()

    var body: some View {
        ErrorView(
            title: "No Pokémon found",
            icon: "doc.questionmark.fill",
            description: "We couldn't find any Pokémon at the moment.",
            buttonText: "Try again") {
                retry()
            }
    }
}

#Preview {
    PokedexEmptyView {
        // Do nothing
    }
}
