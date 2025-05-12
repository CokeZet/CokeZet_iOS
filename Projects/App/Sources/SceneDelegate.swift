//
//  SceneDelegate.swift
//  CokeZet-App
//
//  Created by 김진우 on 1/16/25.
//

import UIKit

import ModernRIBs

import CokeZet_Core

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
        }
    }
}


public class AppComponent: Component<EmptyDependency>, RootDependency {
    var navigationStream: NavgiationBarActions
    
    
    public init() {
        self.navigationStream = NavigationStreamState()
        super.init(dependency: EmptyComponent())
    }
}


