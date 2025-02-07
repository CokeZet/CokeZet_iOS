//
//  Builder.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs

public protocol ProductDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ProductDetailComponent: Component<ProductDetailDependency> {
    
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

public protocol ProductDetailBuildable: Buildable {
    func build() -> LaunchRouting
}

public final class ProductDetailBuilder: Builder<ProductDetailDependency>, ProductDetailBuildable {
    
    public override init(dependency: ProductDetailDependency) {
        super.init(dependency: dependency)
    }
    
    public func build() -> LaunchRouting {
        let component = ProductDetailComponent(dependency: dependency)
        let viewController = ProductDetailViewController()
        let interactor = ProductDetailInteractor(presenter: viewController)
        return ProductDetailRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}

