//
//  Endpoint.swift
//  CokeZet-Network
//
//  Created by 김진우 on 1/16/25.
//
import Foundation

enum Endpoint: EndpointProtocol {
    case example
    
    var token: String { "123456789" }
    var baseURL: URL? { URL(string: "http://example.com") }

    var path: String {
        switch self {
        case .example: "example" // http://example.com/example
        }
    }

    var method: NetworkMethod {
        switch self {
        case .example: .get
        }
    }

    var parameters: [URLQueryItem]? {
        switch self {
        case .example:
            return [
                URLQueryItem(name: "eat", value: "true"),
                URLQueryItem(name: "drink", value: "true"),
            ]
        }
    }

    var headers: [String: String]? {
        switch self {
        case .example:
            [
                "Content-Type": "application/json",
                "Authorization": "Bearer " + token
            ]
        }
    }
    
    var body: Encodable? {
        switch self {
        case .example: nil
        }
    }
}
