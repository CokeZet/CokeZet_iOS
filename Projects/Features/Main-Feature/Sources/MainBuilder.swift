//
//  Builder.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs
import ProductDetail_Feature
import CokeZet_Core

public protocol MainDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var navigationStream: NavgiationBarActions { get }
}

final class MainComponent: Component<MainDependency>, ProductDetailDependency {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    var navigationStream: NavgiationBarActions { dependency.navigationStream }
    
}

// MARK: - Builder

public protocol MainBuildable: Buildable {
//    func build() -> LaunchRouting
    func build(withListener listener: MainListener) -> ViewableRouting
}

public final class MainBuilder: Builder<MainDependency>, MainBuildable {
    
    public override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: MainListener) -> ViewableRouting {
        let component = MainComponent(dependency: dependency)
        let viewController = MainViewController(navigationBarType: .main)
        let interactor = MainInteractor(presenter: viewController, dependency: dependency)
        let productDetailBuilder = ProductDetailBuilder(dependency: component)
        interactor.listener = listener
        
        return MainRouter(
            interactor: interactor,
            productDetailBuildable: productDetailBuilder,
            viewController: viewController
        )
    }
}

