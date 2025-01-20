//
//  AppDelegate.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import UIKit
import ModernRIBs

import CokeZet_Core

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let launchRouter = RootBuilder(dependency: AppComponent()).build()
        self.launchRouter = launchRouter
        launchRouter.launch(from: window)
        return true
    }


}

public class AppComponent: Component<EmptyDependency>, RootDependency {
    
    public init() {
        super.init(dependency: EmptyComponent())
    }
}

