//
//  LoginRequest.swift
//  CokeZet-Network
//
//  Created by 김진우 on 3/26/25.
//

struct LoginRequest: Encodable {
    let idToken: String
    let provider: String
}
