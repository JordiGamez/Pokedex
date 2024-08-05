//
//  ErrorView.swift
//  Pokedex
//
//  Created by Jordi Gamez on 17/4/24.
//

import SwiftUI

public struct ErrorView: View {

    let title: String
    let icon: String
    let description: String
    let buttonText: String
    let buttonAction : () -> ()

    public init(
        title: String,
        icon: String,
        description: String,
        buttonText: String,
        buttonAction: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.description = description
        self.buttonText = buttonText
        self.buttonAction = buttonAction
    }

    public var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: icon)
        } description: {
            Text(description)
        } actions: {
            Button(buttonText) {
                buttonAction()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ErrorView(
        title: "title",
        icon: "doc.questionmark.fill",
        description: "description",
        buttonText: "Try again") {
            // Do nothing
        }
}
