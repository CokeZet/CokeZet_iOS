//
//  Ribs+Utils.swift
//  Core
//
//  Created by 김진우 on 1/15/25.
//

import UIKit
import ModernRIBs

public final class NavigationControllerable: ViewControllable {
    
    public var uiviewController: UIViewController { self.navigationController }
    public let navigationController: UINavigationController
    
    public init(root: ViewControllable) {
        let navigation = UINavigationController(rootViewController: root.uiviewController)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        
        navigation.navigationBar.standardAppearance = appearance
        navigation.navigationBar.scrollEdgeAppearance = appearance
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.scrollEdgeAppearance = navigation.navigationBar.standardAppearance
        
        self.navigationController = navigation
    }
}

public extension ViewControllable {
    
    func present(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        self.uiviewController.present(viewControllable.uiviewController, animated: true, completion: completion)
    }
    
    func dismiss(completion: (() -> Void)?) {
        self.uiviewController.dismiss(animated: true, completion: completion)
    }
    
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.pushViewController(viewControllable.uiviewController, animated: animated)
        } else {
            self.uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
        }
    }
    
    func popViewController(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popViewController(animated: animated)
        }
    }
    
    func popToRoot(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popToRootViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func setViewControllers(_ viewControllerables: [ViewControllable]) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        } else {
            self.uiviewController.navigationController?.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        }
    }
}
