//
//  UserSetting.swift
//  CokeZet-Configurations
//
//  Created by 김진우 on 4/25/25.
//

public struct UserSetting: Codable, Equatable {
    public var nickname: String
    public var commerceIds: [Int]
    public var cardCompanyIds: [Int]

    public init(nickname: String = "", commerceIds: [Int] = [], cardCompanyIds: [Int] = []) {
        self.nickname = nickname
        self.commerceIds = commerceIds
        self.cardCompanyIds = cardCompanyIds
    }
}
