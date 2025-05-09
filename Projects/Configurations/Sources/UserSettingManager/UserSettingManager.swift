//
//  UserSettingManager.swift
//  CokeZet-Configurations
//
//  Created by 김진우 on 4/25/25.
//

import Foundation

public class UserSettingsManager: UserSettingManaging {

    // UserDefaults 인스턴스를 저장하는 프로퍼티 (외부 주입 가능)
    private let userDefaults: UserDefaults
    // UserDefaults에 데이터를 저장할 때 사용할 키
    private let userSettingsKey: String
    
    public static let shared = UserSettingsManager(userDefaults: .standard, key: "userSettings")

    /// 초기화 메서드
    /// - Parameters:
    ///   - userDefaults: 사용할 UserDefaults 인스턴스 (기본값: .standard)
    ///   - key: 데이터를 저장할 UserDefaults 키 (기본값: "userSettings")
    private init(userDefaults: UserDefaults = .standard, key: String = "userSettings") {
        self.userDefaults = userDefaults
        self.userSettingsKey = key
    }

    /// UserSettings 데이터를 UserDefaults에 저장하는 함수
    public func saveSettings(_ settings: UserSetting) -> Bool {
        do {
            let data = try JSONEncoder().encode(settings)
            userDefaults.set(data, forKey: userSettingsKey)
            
            return true
        } catch {
            // 인코딩 또는 저장 중 오류 발생 시 콘솔에 오류 메시지를 출력합니다.
            print("Error saving user settings: \(error.localizedDescription)")
            return false
        }
    }

    /// UserDefaults에서 UserSettings 데이터를 불러오는 함수
    public func loadSettings() -> UserSetting? {
        // 주입받은 UserDefaults 인스턴스에서 키에 해당하는 데이터를 가져옵니다.
        guard let data = userDefaults.data(forKey: userSettingsKey) else {
            return nil // 데이터가 없으면 nil 반환
        }

        do {
            // 가져온 JSON Data를 UserSettings 객체로 디코딩합니다.
            let settings = try JSONDecoder().decode(UserSetting.self, from: data)
            return settings
        } catch {
            // 디코딩 중 오류 발생 시 콘솔에 오류 메시지를 출력하고 nil을 반환합니다.
            print("Error loading user settings: \(error.localizedDescription)")
            return nil
        }
    }

    /// UserDefaults에서 UserSettings 데이터를 삭제하는 함수
    public func clearSettings() {
        userDefaults.removeObject(forKey: userSettingsKey)
    }
}
