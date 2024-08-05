//
//  Color+Extensions.swift
//  
//  Created by Jordi Gamez on 26/3/24.
//

import SwiftUI

extension Color {

    static func color(_ name: String) -> Color {
        Color(
            UIColor(
                named: name,
                in: .module,
                compatibleWith: nil
            ) ?? .white // fallback color to avoid crash
        )
    }
}
