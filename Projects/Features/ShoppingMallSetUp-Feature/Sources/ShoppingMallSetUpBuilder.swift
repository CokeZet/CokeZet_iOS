//
//  Builder.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs
import CokeZet_Configurations

public protocol ShoppingMallSetUpDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var userSetting: UserSetting { get set }
}

final class ShoppingMallSetUpComponent: Component<ShoppingMallSetUpDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol ShoppingMallSetUpBuildable: Buildable {
    func build(withListener listener: ShoppingMallSetUpListener) -> ViewableRouting
}

public final class ShoppingMallSetUpBuilder: Builder<ShoppingMallSetUpDependency>, ShoppingMallSetUpBuildable {
    
    public override init(dependency: ShoppingMallSetUpDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: ShoppingMallSetUpListener) -> ViewableRouting {
        let component = ShoppingMallSetUpComponent(dependency: dependency)
        let viewController = ShoppingMallSetUpViewController(nickname: dependency.userSetting.nickname)
        
        let interactor = ShoppingMallSetUpInteractor(
            presenter: viewController,
            dependency: dependency
        )
        
        interactor.listener = listener
        
        return ShoppingMallSetUpRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}

