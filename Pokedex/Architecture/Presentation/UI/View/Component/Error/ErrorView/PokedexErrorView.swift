//
//  PokedexErrorView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 17/4/24.
//

import SwiftUI
import DesignSystem

struct PokedexErrorView: View {

    let retry : () -> ()

    var body: some View {
        ErrorView(
            title: "No Pokémon found",
            icon: "exclamationmark.triangle.fill",
            description: "There was an error trying to load the Pokédex.",
            buttonText: "Try again") {
                retry()
            }
    }
}

#Preview {
    PokedexErrorView {
        // Do nothing
    }
}
