//
//  DeleteProfile.swift
//  CokeZet-Network
//
//  Created by 김진우 on 5/11/25.
//

public struct DeleteProfile: Codable {
    public let socialProvider: String
    public let revokeToken: String
    
    public init(socialProvider: String, revokeToken: String) {
        self.socialProvider = socialProvider
        self.revokeToken = revokeToken
    }
}
