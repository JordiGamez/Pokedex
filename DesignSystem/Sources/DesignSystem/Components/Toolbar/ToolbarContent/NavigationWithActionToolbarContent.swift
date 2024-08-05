//
//  NavigationWithActionToolbarContent.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI

public struct NavigationWithActionToolbarContent: ToolbarContent {

    private let isActionSelected: Bool
    private let backButtonImageName: String
    private let actionButtonImageName: String
    private let didTapBack: () -> ()
    private let didTapAction: () -> ()

    public init(
        isActionSelected: Bool,
        backButtonImageName: String,
        actionButtonImageName: String,
        didTapBack: @escaping () -> (),
        didTapAction: @escaping () -> ()
    ) {
        self.isActionSelected = isActionSelected
        self.backButtonImageName = backButtonImageName
        self.actionButtonImageName = actionButtonImageName
        self.didTapBack = didTapBack
        self.didTapAction = didTapAction
    }

    public var body: some ToolbarContent {
        backButton
        actionButton
    }
}

private extension NavigationWithActionToolbarContent {

    var backButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            UIToolkit.buttonToolbarIcon(
                state: .normal,
                imageName: backButtonImageName
            ) {
                didTapBack()
            }
        }
    }

    var actionButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            UIToolkit.buttonToolbarIcon(
                state: isActionSelected ? .selected : .normal,
                imageName: actionButtonImageName
            ) {
                didTapAction()
            }
        }
    }
}
