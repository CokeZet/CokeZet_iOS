
import Foundation
import CokeZet_Configurations

// 전체 JSON 응답 구조체
public struct AuthResponse<T: Codable>: Codable {
    public let code: String
    public let message: String
    public let data: T? // 중첩된 'data' 객체를 위한 구조체 타입
}

// 'data' 객체 구조체
public struct AuthData: Codable {
    public let accessToken: String
    public let refreshToken: String
    public let user: User // 중첩된 'user' 객체를 위한 구조체 타입
    public let newUser: Bool
}
