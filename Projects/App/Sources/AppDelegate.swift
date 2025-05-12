//
//  AppDelegate.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {


        // Each UISceneConfiguration have a unique configuration name.
        // The configuration name is a app-specific name
        // you use to identify the scene, and it corresponds to entries
        // in the `Info.plist` scene manifest.
        var configurationName = "Default Configuration"
    
        return UISceneConfiguration(
            name: configurationName,
            sessionRole: connectingSceneSession.role
        )
    }
}
