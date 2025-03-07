//
//  Builder.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs
import ProductDetail_Feature

public protocol MainDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class MainComponent: Component<MainDependency>, ProductDetailDependency {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let viewController = MainViewController(navigationBarType: .Home)
        let interactor = MainInteractor(presenter: viewController)
        let productDetailBuilder = ProductDetailBuilder(dependency: component)
        
        return MainRouter(
            interactor: interactor,
            productDetailBuildable: productDetailBuilder,
            viewController: viewController
        )
    }
}

