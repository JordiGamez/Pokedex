//
//  ActionToolbarContent.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI

public struct ActionToolbarContent: ToolbarContent {

    private let logoImage: Image?
    private let action: ToolbarAction
    private let didTapAction: () -> ()

    public init(
        logoImage: Image? = nil,
        action: ToolbarAction,
        didTapAction: @escaping () -> ()
    ) {
        self.logoImage = logoImage
        self.action = action
        self.didTapAction = didTapAction
    }

    public var body: some ToolbarContent {
        if let logoImage {
            logoIfNeeded(logoImage)
        }
        actionButton
    }
}

private extension ActionToolbarContent {

    func logoIfNeeded(_ logoImage: Image) -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            ToolbarItemsBuilder.logoIcon(logo: logoImage)
        }
    }

    var actionButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            UIToolkit.buttonToolbarIcon(
                state: .normal,
                imageName: action.imageName
            ) {
                didTapAction()
            }
        }
    }
}
