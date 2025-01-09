//
//  TermsOfServiceBuilder.swift
//  Features
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs

public protocol TermsOfServiceDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TermsOfServiceComponent: Component<TermsOfServiceDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol TermsOfServiceBuildable: Buildable {
    func build(withListener listener: TermsOfServiceListener) -> TermsOfServiceRouting
}

public final class TermsOfServiceBuilder: Builder<TermsOfServiceDependency>, TermsOfServiceBuildable {

    public override init(dependency: TermsOfServiceDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: TermsOfServiceListener) -> TermsOfServiceRouting {
        let component = TermsOfServiceComponent(dependency: dependency)
        let viewController = TermsOfServiceViewController()
        let interactor = TermsOfServiceInteractor(presenter: viewController)
        interactor.listener = listener
        return TermsOfServiceRouter(interactor: interactor, viewController: viewController)
    }
}
