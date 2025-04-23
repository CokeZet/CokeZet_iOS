//
//  RefreshTokenResponse.swift
//  CokeZet-Network
//
//  Created by 김진우 on 4/23/25.
//

public struct RefreshTokenResponse: Codable {
    public let accessToken: String
    public let refreshToken: String
}
