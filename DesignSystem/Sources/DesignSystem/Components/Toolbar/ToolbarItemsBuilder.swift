//
//  ToolbarItemsBuilder.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import SwiftUI

public enum ToolbarItemsBuilder {

    static func iconButton(
        buttonImage: Image,
        buttonAction: ToolbarAction,
        action: ((_ action: ToolbarAction) -> Void)?,
        paddingEdge: Edge.Set,
        isOverDark: Bool = false
    ) -> some View {
        Button {
            action?(buttonAction)
        } label: {
            buttonImage
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.black)
        }
    }

    static func title(
        _ title: String,
        color: Color
    ) -> some View {
        Text(title)
            .fixedSize(horizontal: true, vertical: false)
            .font(.system(.callout))
            .foregroundColor(color)
    }

    static func logoIcon(
        logo: Image
    ) -> some View {
        logo
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: logoHeight)
    }
}

private extension ToolbarItemsBuilder {

    static var logoHeight: CGFloat {
        LayoutDisplay.defaultValue == .tv ? 75 : 35
    }
}
