//
//  Builder.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs

protocol MainDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MainComponent: Component<MainDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build() -> LaunchRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {
    
    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }
    
    public func build() -> LaunchRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController()
        let interactor = MainInteractor(presenter: viewController)
        return MainRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}

