//
//  UIToolkit+Text.swift
//  
//  Created by Jordi Gamez on 17/4/24.
//

import SwiftUI

public extension UIToolkit {

    static func text(
        _ value: String,
        fontModel: Font,
        color: Color,
        multilineTextAlignment: TextAlignment = .leading,
        lineSpacing: CGFloat = 5
    ) -> some View {
        Text(value)
            .foregroundColor(color)
            .font(fontModel)
            .lineSpacing(lineSpacing)
            .multilineTextAlignment(multilineTextAlignment)
    }
}
