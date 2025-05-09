//
//  ProfileEndpoint.swift
//  CokeZet-Network
//
//  Created by 김진우 on 3/26/25.
//

import Foundation
import CokeZet_Configurations

public enum ProfileEndpoint: EndpointProtocol {
    case getProfile
    case updateProfile(user: UserSetting)
    case deleteProfile
    case profileStatus
    
    public var baseURL: URL? { URL(string: "http://52.79.89.114:8080") }
    
    public var token: String? { AuthManager.shared.getAccessToken() }
    
    public var path: String {
        switch self {
        case .getProfile: 
            "api/users/profile"
        case .updateProfile:
            "api/users/profile"
        case .deleteProfile:
            "api/users/profile"
        case .profileStatus:
            "api/users/profile/status"
        }
    }
    
    public var method: NetworkMethod {
        switch self {
        case .getProfile:
                .get
        case .updateProfile:
                .post
        case .deleteProfile:
                .delete
        case .profileStatus:
                .get
        }
    }
    
    public var parameters: [URLQueryItem]? {
        switch self {
        case .getProfile, .updateProfile, .deleteProfile, .profileStatus:
            return nil
        }
    }
    
    public var headers: [String: String]? {
        switch self {
        default:
            guard let token else { return nil }
            return ["Authorization": "Bearer \(token)"]
        }
    }
    
    public var body: Encodable? {
        switch self {
        case .getProfile, .deleteProfile, .profileStatus:
            return nil
        case .updateProfile(let user):
            return ProfileUpdate(nickname: user.nickname, commerceIds: user.commerceIds, cardCompanyIds: user.cardCompanyIds)
        }
    }
}
