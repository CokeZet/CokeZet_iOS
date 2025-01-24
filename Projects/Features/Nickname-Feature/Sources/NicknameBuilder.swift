//
//  Builder.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs
import Features

protocol NicknameDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class NicknameComponent: Component<NicknameDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol NicknameBuildable: Buildable {
    func build() -> LaunchRouting
}

final class NicknameBuilder: Builder<NicknameDependency>, NicknameBuildable {
    
    override init(dependency: NicknameDependency) {
        super.init(dependency: dependency)
    }
    
    public func build() -> LaunchRouting {
        let component = NicknameComponent(dependency: dependency)
        let viewController = NicknameViewController()
        let interactor = NicknameInteractor(presenter: viewController)
        return NicknameRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}

