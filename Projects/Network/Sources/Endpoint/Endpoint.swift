//
//  Endpoint.swift
//  CokeZet-Network
//
//  Created by 김진우 on 1/16/25.
//
import Foundation

public enum Endpoint: EndpointProtocol {
    case example
    
    var token: String { "123456789" }
    public var baseURL: URL? { URL(string: "https://jsonplaceholder.typicode.com") }

    public var path: String {
        switch self {
        case .example: "posts" // https://jsonplaceholder.typicode.com/posts
        }
    }

    public var method: NetworkMethod {
        switch self {
        case .example: .get
        }
    }

    public var parameters: [URLQueryItem]? {
        switch self {
        case .example:
            return [
//                URLQueryItem(name: "eat", value: "true"),
//                URLQueryItem(name: "drink", value: "true"),
            ]
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .example:
            [:
//                "Content-Type": "application/json",
//                "Authorization": "Bearer " + token
            ]
        }
    }
    
    public var body: Encodable? {
        switch self {
        case .example: nil
        }
    }
}
