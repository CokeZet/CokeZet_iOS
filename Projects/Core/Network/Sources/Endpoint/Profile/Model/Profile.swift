//
//  Profile.swift
//  CokeZet-Network
//
//  Created by 김진우 on 4/21/25.
//

public struct Profile: Codable {
    public let id: Int
    public let email: String
    public let nickname: String
    public let profileComplete: Bool
    public let preferredCommerces: [PreferredType]
    public let preferredCardCompanies: [PreferredType]
}

public struct PreferredType: Codable {
    public let id: Int
    public let name: String
}


public struct ProfileUpdate: Codable {
    public let nickname: String
    public let commerceIds: [Int]
    public let cardCompanyIds: [Int]
}
