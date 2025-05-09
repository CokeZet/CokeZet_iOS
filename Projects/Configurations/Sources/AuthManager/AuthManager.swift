//
//  AuthManager.swift
//  CokeZet-Core
//
//  Created by 김진우 on 4/21/25.
//

import Foundation
import Security // 키체인 사용을 위해 필요

// 인증 관련 정보를 관리하는 싱글톤 클래스
public final class AuthManager {
    
    // 싱글톤 인스턴스
    public static let shared = AuthManager()
    
    // 키체인 저장을 위한 설정
    private let keychainService = "CokeZet.CokeZet-App" // 앱 번들 ID 등 고유한 값 권장
    private let accessTokenAccount = "accessToken"
    private let refreshTokenAccount = "refreshToken"
    private let authorizationTokenAccount = "authorizationToken"
    
    // UserDefaults 저장을 위한 키
    private let userDefaultsKey = "currentUser"
    
    // 외부에서 인스턴스 생성을 막기 위한 private init
    private init() {}
    
    // MARK: - Public Methods (외부 호출 인터페이스)
    
    /// 로그인 성공 시 인증 정보를 저장합니다.
    /// - Parameters:
    ///   - accessToken: 액세스 토큰
    ///   - refreshToken: 리프레시 토큰
    ///   - user: 사용자 정보 객체
    /// - Returns: 모든 정보 저장 성공 여부
    @discardableResult // 반환값을 사용하지 않아도 경고가 뜨지 않도록 함
    public func saveAuthData(accessToken: String, refreshToken: String, authorizationToken: String, user: User) -> Bool {
        let isTokenSaved = saveTokenToKeychain(token: accessToken, account: accessTokenAccount) &&
        saveTokenToKeychain(token: refreshToken, account: refreshTokenAccount) &&
        saveTokenToKeychain(token: authorizationToken, account: authorizationTokenAccount)
        
        let isUserSaved = saveUserToDefaults(user: user)
        
        if !isTokenSaved {
            print("AuthManager Error: 토큰 저장 실패")
            // 필요시 저장 실패한 토큰 삭제 로직 추가
            deleteTokenFromKeychain(account: accessTokenAccount)
            deleteTokenFromKeychain(account: refreshTokenAccount)
            deleteTokenFromKeychain(account: authorizationTokenAccount)
        }
        if !isUserSaved {
            print("AuthManager Error: 사용자 정보 저장 실패")
            // 필요시 저장 실패한 사용자 정보 삭제 로직 추가
            deleteUserFromDefaults()
        }
        
        return isTokenSaved && isUserSaved
    }
    
    
    // *** 추가: 토큰만 업데이트하는 함수 ***
    /// 키체인에 저장된 토큰들만 업데이트합니다. (토큰 갱신 성공 시 사용)
    /// - Parameters:
    ///   - accessToken: 새 액세스 토큰
    ///   - refreshToken: 새 리프레시 토큰
    /// - Returns: 두 토큰 모두 저장 성공 여부
    @discardableResult
    public func updateTokens(accessToken: String, refreshToken: String) -> Bool {
        let isAccessSaved = saveTokenToKeychain(token: accessToken, account: accessTokenAccount)
        let isRefreshSaved = saveTokenToKeychain(token: refreshToken, account: refreshTokenAccount)
        
        if !isAccessSaved || !isRefreshSaved {
            print("AuthManager Error: 토큰 업데이트 실패")
            // 실패 시 복구 전략 필요 (예: 기존 토큰 유지 시도 또는 로그아웃)
        } else {
            print("AuthManager: Tokens updated successfully.")
        }
        return isAccessSaved && isRefreshSaved
    }
    
    
    
    /// 저장된 액세스 토큰을 반환합니다.
    /// - Returns: 액세스 토큰 (없으면 nil)
    public func getAccessToken() -> String? {
        return loadTokenFromKeychain(account: accessTokenAccount)
    }
    
    /// 저장된 리프레시 토큰을 반환합니다.
    /// - Returns: 리프레시 토큰 (없으면 nil)
    public func getRefreshToken() -> String? {
        return loadTokenFromKeychain(account: refreshTokenAccount)
    }
    
    /// 저장된 애플 Authorization 토큰을 반환합니다.
    /// - Returns: Authorization 토큰 (없으면 nil)
    public func getAuthorizationToken() -> String? {
        return loadTokenFromKeychain(account: authorizationTokenAccount)
    }
    
    /// 저장된 현재 사용자 정보를 반환합니다.
    /// - Returns: User 객체 (없으면 nil)
    public func getCurrentUser() -> User? {
        return loadUserFromDefaults()
    }
    
    /// 현재 로그인 상태인지 확인합니다. (예: 액세스 토큰과 사용자 정보가 모두 있는지)
    /// - Returns: 로그인 상태 여부
    public func isLoggedIn() -> Bool {
        return getAccessToken() != nil && getCurrentUser() != nil
    }
    
    /// 저장된 모든 인증 정보 (토큰, 사용자 정보)를 삭제합니다. (로그아웃 시 사용)
    public func logout() {
        deleteTokenFromKeychain(account: accessTokenAccount)
        deleteTokenFromKeychain(account: refreshTokenAccount)
        deleteTokenFromKeychain(account: authorizationTokenAccount)
        
        deleteUserFromDefaults()
        print("AuthManager: 모든 인증 정보 삭제 완료 (로그아웃)")
    }
    
    
    // MARK: - Private Keychain Helpers (내부 키체인 처리)
    
    /// 키체인에 토큰을 저장하는 내부 함수
    private func saveTokenToKeychain(token: String, account: String) -> Bool {
        guard let data = token.data(using: .utf8) else { return false }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        
        // 기존 항목 삭제 (업데이트를 위해)
        SecItemDelete(query as CFDictionary)
        
        // 새 항목 추가
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    /// 키체인에서 토큰을 로드하는 내부 함수
    private func loadTokenFromKeychain(account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess, let data = dataTypeRef as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            // errSecItemNotFound 등 다른 오류 상태 처리 가능
            if status != errSecItemNotFound {
                print("AuthManager Keychain Error: 토큰 로드 실패 (상태 코드: \(status))")
            }
            return nil
        }
    }
    
    /// 키체인에서 특정 토큰을 삭제하는 내부 함수
    private func deleteTokenFromKeychain(account: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: account
        ]
        let status = SecItemDelete(query as CFDictionary)
        if status != errSecSuccess && status != errSecItemNotFound {
            print("AuthManager Keychain Error: 토큰 삭제 실패 (계정: \(account), 상태 코드: \(status))")
        }
    }
    
    
    // MARK: - Private UserDefaults Helpers (내부 UserDefaults 처리)
    
    /// UserDefaults에 User 객체를 저장하는 내부 함수 (Codable 사용)
    private func saveUserToDefaults(user: User) -> Bool {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
            return true
        } catch {
            print("AuthManager UserDefaults Error: User 인코딩 또는 저장 실패 - \(error)")
            return false
        }
    }
    
    /// UserDefaults에서 User 객체를 로드하는 내부 함수 (Codable 사용)
    private func loadUserFromDefaults() -> User? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey) else {
            return nil // 저장된 데이터 없음
        }
        do {
            let decoder = JSONDecoder()
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch {
            print("AuthManager UserDefaults Error: User 디코딩 실패 - \(error)")
            return nil
        }
    }
    
    /// UserDefaults에서 User 정보를 삭제하는 내부 함수
    private func deleteUserFromDefaults() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
}
