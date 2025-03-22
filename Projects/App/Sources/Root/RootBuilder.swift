//
//  RootBuilder.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs
import Main_Feature
import Setting_Feature
import Login_Feature
import CokeZet_Core

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var navigationStream: NavgiationBarActions { get }
}

final class RootComponent: Component<RootDependency>, MainDependency, SettingDependency, LoginDependency {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let navigationStream: NavgiationBarActions
    
    override init(dependency: RootDependency) {
        self.navigationStream = dependency.navigationStream
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
    
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    public func build() -> LaunchRouting {
        let component = RootComponent(dependency: dependency)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController, dependency: dependency)
        let mainBuilder = MainBuilder(dependency: component)
        let settingBuilder = SettingBuilder(dependency: component)
        let loginBuilder = LoginBuilder(dependency: component)
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            mainBuildable: mainBuilder,
            settingBuilable: settingBuilder,
            loginBuildable: loginBuilder
        )
    }
}

