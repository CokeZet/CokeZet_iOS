//
//  LoginEndpoint.swift
//  CokeZet-Network
//
//  Created by 김진우 on 3/26/25.
//

import Foundation

public enum LoginEndpoint: EndpointProtocol {
    case login(token: String)
    
    public var baseURL: URL? { URL(string: "http://52.79.89.114:8080") }
    
    public var path: String {
        switch self {
        case .login: "api/auth/login"
        }
    }
    
    public var method: NetworkMethod {
        switch self {
        case .login: .post
        }
    }
    
    public var parameters: [URLQueryItem]? {
        switch self {
        case .login:
            return nil
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        case .login:
            return [
                "Content-Type": "application/json",
                "accept": "application/json"
            ]
        }
    }
    
    public var body: Encodable? {
        switch self {
        case .login(let token):
            return LoginRequest(
                idToken: token,
                provider: "APPLE"
            )
        }
    }
}
