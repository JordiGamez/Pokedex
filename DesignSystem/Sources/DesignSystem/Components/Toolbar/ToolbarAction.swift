//
//  ToolbarAction.swift
//
//  Created by Jordi Gamez on 12/6/24.
//

import Foundation

public enum ToolbarAction {
    
    case goBack
    case favorite

    var imageName: String {
        switch self {
        case .goBack:
            "arrow.left.circle.fill"
        case .favorite:
            "heart.circle.fill"
        }
    }
}
