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
    case guestLogin
    
    public var baseURL: URL? { URL(string: "http://54.180.163.219:8080") }
    
    public var path: String {
        switch self {
        case .login: "api/auth/login"
        case .logout: "api/auth/logout"
        case .refresh: "api/auth/refresh"
        case .guestLogin: "api/guest/token"
        }
    }
    
    public var method: NetworkMethod {
        switch self {
        case .login: .post
        case .logout: .post
        case .refresh: .post
        case .guestLogin: .post
        }
    }
    
    public var parameters: [URLQueryItem]? {
        switch self {
        case .login, .logout, .refresh, .guestLogin:
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
        case .refresh(let refreshToken):
            return ["refreshToken": refreshToken]
        case .logout, .guestLogin:
            return nil
        }
    }
}
