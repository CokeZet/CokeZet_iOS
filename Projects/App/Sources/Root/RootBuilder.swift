//
//  RootBuilder.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs
import Main_Feature
import Setting_Feature

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency>, MainDependency, SettingDependency {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let interactor = RootInteractor(presenter: viewController)
        let mainBuilder = MainBuilder(dependency: component)
        let settingBuilder = SettingBuilder(dependency: component)
        
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            mainBuildable: mainBuilder,
            settingBuilable: settingBuilder
        )
    }
}

