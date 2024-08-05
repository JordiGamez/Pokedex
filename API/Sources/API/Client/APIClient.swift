//
//  APIClient.swift
//  Pokedex
//
//  Created by Jordi Gamez on 16/4/24.
//

import Foundation

public struct APIClient {
    
    // Status code ranges and specific codes
    private static let statusCodeOK = 200...299
    private static let statusCodeBadRequest = 400
    private static let statusCodeUnauthorized = 401
    private static let statusCodeForbidden = 403
    private static let statusCodeNotFound = 404
    private static let statusCodeConflict = 409
    private static let statusCodeGone = 410
    private static let statusCodeServerError = 500...599

    // Mapping status codes to errors
    private static let statusCodeToError: [Int: DataError] = [
        statusCodeBadRequest: .badRequest,
        statusCodeUnauthorized: .unauthorized,
        statusCodeForbidden: .forbidden,
        statusCodeNotFound: .notFound,
        statusCodeConflict: .conflict,
        statusCodeGone: .gone
    ]

    public static func request<T: Codable>(_ urlRequest: URLRequest?) async throws -> T {
        // Ensure the URL is valid
        guard let urlRequest else {
            throw DataError.invalidUrl
        }
        
        // Perform the request
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        // Ensure the response is an HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw DataError.unknown
        }
        
        // Check the status code
        try checkStatusCode(httpResponse)

        // Decode the data into the expected type
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw DataError.decoding
        }
    }
}

private extension APIClient {

    static func checkStatusCode(_ response: HTTPURLResponse) throws {
        let statusCode = response.statusCode

        if statusCodeOK.contains(statusCode) {
            return
        }
        
        if let error = statusCodeToError[statusCode] {
            throw error
        }

        if statusCodeServerError.contains(statusCode) {
            throw DataError.server
        }

        // If no specific error found, throw unknown error
        throw DataError.unknown
    }
}
