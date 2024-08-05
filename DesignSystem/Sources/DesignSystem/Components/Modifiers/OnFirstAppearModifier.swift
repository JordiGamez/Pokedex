//
//  OnFirstAppearModifier.swift
//
//  Created by Jordi Gamez on 16/4/24.
//

import SwiftUI

public extension View {

    func onFirstAppear(_ action: (() -> Void)? = nil) -> some View {
        modifier(OnFirstAppearModifier(action: action))
    }
}

struct OnFirstAppearModifier: ViewModifier {

    var action: (() -> Void)?

    @State private var didAppeared = false

    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !didAppeared else {
                    return
                }
                didAppeared = true
                action?()
            }
    }
}
