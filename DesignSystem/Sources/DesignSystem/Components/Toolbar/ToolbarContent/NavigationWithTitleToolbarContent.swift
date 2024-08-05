//
//  NavigationWithTitleToolbarContent.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI

public struct NavigationWithTitleToolbarContent: ToolbarContent {

    @EnvironmentObject var theme: ThemeManager

    private let title: String
    private let subtitle: String
    private let backButtonImageName: String
    private let didTapBack: () -> ()

    public init(
        title: String,
        subtitle: String = "",
        backButtonImageName: String,
        didTapBack: @escaping () -> ()
    ) {
        self.title = title
        self.subtitle = subtitle
        self.backButtonImageName = backButtonImageName
        self.didTapBack = didTapBack
    }

    public var body: some ToolbarContent {
        backButton
        header
    }
}

private extension NavigationWithTitleToolbarContent {

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

    var header: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                UIToolkit.text(
                    title,
                    fontModel: theme.font.headline,
                    color: theme.color.textPrimary
                )

                UIToolkit.text(
                    subtitle,
                    fontModel: theme.font.caption,
                    color: theme.color.textPrimary
                )
                .if(subtitle == "") { view in
                    view
                        .hidden()
                }
            }
        }
    }
}
