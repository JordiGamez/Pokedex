//
//  URLRequestConvertible.swift
//  Pokedex
//
//  Created by Jordi Gamez on 11/6/24.
//

import Foundation

public protocol URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var endpoint: URL? { get }
}

public extension URLRequestConvertible {

    var urlRequest: URLRequest? { asURLRequest() }
}

private extension URLRequestConvertible {

    private func asURLRequest() -> URLRequest? {
        // Ensure the endpoint URL is valid
        guard let endpoint else {
            return nil
        }

        // Create URLRequest
        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        
        return request
    }
}
