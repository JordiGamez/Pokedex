//
//  EmptyButtonStyle.swift
//
//  Created by Jordi Gamez on 4/5/24.
//

import SwiftUI

public struct EmptyButtonStyle: ButtonStyle {

    public init() {
        // Intentionally empty
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}
