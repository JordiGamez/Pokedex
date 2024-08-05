//
//  Image+Ext.swift
//  Pokedex
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI

extension Image {

    static let logoImageName: String = "pokedex"
    static let loadingImageName: String = "pokeball"

    static var logo: Image {
        Image(logoImageName, bundle: .main)
    }

    static var loading: Image {
        Image(loadingImageName, bundle: .main)
    }
}
