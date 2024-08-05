//
//  Font+Extensions.swift
//  
//  Created by Jordi Gamez on 26/3/24.
//

import SwiftUI

extension Font {

    static func font(
        weight: Weight,
        style: UIFont.TextStyle
    ) -> Font {
        .system(
            size: UIFont.preferredFont(forTextStyle: style).pointSize,
            weight: weight
        )
    }
}
