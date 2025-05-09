//
//  UserSetting.swift
//  CokeZet-Configurations
//
//  Created by 김진우 on 4/25/25.
//

public protocol UserSettingManaging {
    /// UserSettings 데이터를 저장하는 함수
    /// - Parameter settings: 저장할 UserSettings 객체
    /// - Returns: 저장 성공 여부 (성공: true, 실패: false)
    func saveSettings(_ settings: UserSetting) -> Bool

    /// 저장된 UserSettings 데이터를 불러오는 함수
    /// - Returns: 불러온 UserSettings 객체 (데이터가 없거나 오류 발생 시 nil 반환)
    func loadSettings() -> UserSetting?

    /// 저장된 UserSettings 데이터를 삭제하는 함수
    func clearSettings()
}
