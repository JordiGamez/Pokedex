//
//  SearchUIGroup.swift
//  PokedexUITests
//
//  Created by Jordi Gamez on 4/8/24.
//

import SwiftUI
import SnapshotTesting

final class SearchUIGroup: UIGroup {

    static var identifier: String = "search"

    static func screenshots(_ viewController: UIViewController, name: String, scheme: ColorScheme) {
        _ = UITheme.Devices.list.map { device in
            viewController.overrideUserInterfaceStyle = scheme.interfaceStyle
            assertSnapshot(
                matching: viewController,
                as: .image(on: device.value),
                named: "\(identifier)-\(name)-\(device.key)-\(scheme.interfaceStyle.name)"
            )
        }
    }
}
