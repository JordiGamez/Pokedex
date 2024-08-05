//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Jordi Gamez on 26/3/24.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture

@main
struct PokedexApp: App {

    @StateObject private var themeManager = ThemeManager.main

    var body: some Scene {
        WindowGroup {
            TabView {
                Group {
                    pokedex
                    search
                }
                .toolbarBackground(themeManager.color.actionBackgroundPrimary, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }
            .tint(themeManager.color.actionTextPrimary)
        }
    }
}

private extension PokedexApp {

    var pokedex: some View {
        PokedexPage(store: StoreManager.pokedexStore())
            .environmentObject(themeManager)
            .tabItem {
                Label(
                    "Pokedex",
                    systemImage: "list.clipboard.fill"
                )
            }
    }

    var search: some View {
        SearchPage(store: StoreManager.searchStore())
            .environmentObject(themeManager)
            .tabItem {
                Label(
                    "Search",
                    systemImage: "doc.text.magnifyingglass"
                )
            }
    }
}
