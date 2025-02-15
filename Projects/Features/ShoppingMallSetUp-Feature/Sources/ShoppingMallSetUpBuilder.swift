//
//  Builder.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs
import Features

protocol ShoppingMallSetUpDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ShoppingMallSetUpComponent: Component<ShoppingMallSetUpDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ShoppingMallSetUpBuildable: Buildable {
    func build() -> LaunchRouting
}

final class ShoppingMallSetUpBuilder: Builder<ShoppingMallSetUpDependency>, ShoppingMallSetUpBuildable {
    
    override init(dependency: ShoppingMallSetUpDependency) {
        super.init(dependency: dependency)
    }
    
    public func build() -> LaunchRouting {
        let component = ShoppingMallSetUpComponent(dependency: dependency)
        let viewController = ShoppingMallSetUpViewController()
        let interactor = ShoppingMallSetUpInteractor(presenter: viewController)
        return ShoppingMallSetUpRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}

