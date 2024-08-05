//
//  LogoToolBarContent.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI

public struct LogoToolBarContent: ToolbarContent {

    private let logoImage: Image

    public init(logoImage: Image) {
        self.logoImage = logoImage
    }

    public var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            ToolbarItemsBuilder.logoIcon(logo: logoImage)
        }
    }
}
