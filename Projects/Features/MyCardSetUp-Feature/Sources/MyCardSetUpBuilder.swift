//
//  Builder.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs

public protocol MyCardSetUpDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MyCardSetUpComponent: Component<MyCardSetUpDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol MyCardSetUpBuildable: Buildable {
    func build(withListener listener: MyCardSetUpListener) -> ViewableRouting
}

public final class MyCardSetUpBuilder: Builder<MyCardSetUpDependency>, MyCardSetUpBuildable {
    
    public override init(dependency: MyCardSetUpDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: MyCardSetUpListener) -> ViewableRouting {
        let component = MyCardSetUpComponent(dependency: dependency)
        let viewController = MyCardSetUpViewController()
        let interactor = MyCardSetUpInteractor(presenter: viewController)
        interactor.listener = listener
        
        return MyCardSetUpRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}

