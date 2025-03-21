//
//  Configure.swift
//  CokeZet-App
//
//  Created by 김진우 on 3/21/25.
//

import Foundation

public actor Config {
    
    public static let shared = Config()
    
    private struct Key {
        public static let login = "login_flag"
    }
    
    public func saveLogin(_ flag: Bool) {
        UserDefaults.standard.set(flag, forKey: Key.login)
    }
    
    public func getLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: Key.login)
    }
    
}
