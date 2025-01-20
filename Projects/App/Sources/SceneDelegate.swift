//
//  SceneDelegate.swift
//  CokeZet-App
//
//  Created by 김진우 on 1/16/25.
//

import UIKit
import ModernRIBs

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window

            let launchRouter = RootBuilder(dependency: AppComponent()).build()
            self.launchRouter = launchRouter
            launchRouter.launch(from: window)
            print("bulid toto")
        }
    }
}

