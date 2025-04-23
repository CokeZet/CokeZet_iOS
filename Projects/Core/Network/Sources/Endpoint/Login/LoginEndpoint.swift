//
//  LoginEndpoint.swift
//  CokeZet-Network
//
//  Created by 김진우 on 3/26/25.
//

import Foundation

public enum LoginEndpoint: EndpointProtocol {
    case login(token: String)
    case logout(token: String)
    case refresh(refreshToken: String)
    
    public var baseURL: URL? { URL(string: "http://52.79.89.114:8080") }
    
    public var path: String {
        switch self {
        case .login: "api/auth/login"
        case .logout: "api/auth/logout"
        case .refresh: "api/auth/refresh"
        }
    }
    
    public var method: NetworkMethod {
        switch self {
        case .login: .post
        case .logout: .post
        case .refresh: .post
        }
    }
    
    public var parameters: [URLQueryItem]? {
        switch self {
        case .login, .logout, .refresh:
            return nil
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        default:
            return nil
        }
    }
    
    public var body: Encodable? {
        switch self {
        case .login(let token):
            return LoginRequest(
                idToken: token,
                provider: "APPLE"
            )
        case . logout:
            return nil
        case .refresh(let refreshToken):
            return ["refreshToken": refreshToken]
        }
    }
}
