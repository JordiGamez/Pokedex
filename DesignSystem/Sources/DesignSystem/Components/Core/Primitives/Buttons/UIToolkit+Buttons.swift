//
//  UIToolkit+Buttons.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI

public extension UIToolkit {

    private static let buttonSize: CGFloat = 30

    static func buttonText(
        _ text: String,
        fontModel: Font,
        color: Color,
        onTap: @escaping () -> Void
    ) -> some View {
        Button(
            action: { onTap() },
            label: {
                UIToolkit.text(
                    text,
                    fontModel: fontModel,
                    color: color
                )
            }
        )
        .buttonStyle(PrimaryButtonStyle())
    }

    static func buttonIcon(
        state: ButtonState,
        imageName: String,
        onTap: @escaping () -> Void
    ) -> some View {
        Button(
            action: { onTap() }
        ) {
            UIToolkit.systemImage(
                name: imageName,
                size: buttonSize
            )
        }
        .buttonStyle(PrimaryButtonStyle())
    }

    static func buttonToolbarIcon(
        state: ButtonState,
        imageName: String,
        onTap: @escaping () -> Void
    ) -> some View {
        Button(
            action: { onTap() }
        ) {
            UIToolkit.systemImage(
                name: imageName,
                size: buttonSize
            )
        }
        .if(state == .selected, { view in
            view
                .buttonStyle(SelectedToolbarButtonStyle())
        }, else: { view in
            view
                .buttonStyle(ToolbarButtonStyle())
        })
    }
}
