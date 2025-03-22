//
//  Builder.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs
import Combine

public protocol ProductDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ProductDetailComponent: Component<ProductDetailDependency>, PriceComparisonMoreDependency, TransportHomeInteractorDependency {
    var cellDataPublisher: CurrentValueSubject<ProductDetailViewController.State, Never>
    
    var productList: CurrentValueSubject<[PriceComparisonTableViewCell.State], Never>
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    override init(
        dependency: ProductDetailDependency
    ) {
        self.cellDataPublisher = CurrentValueSubject<ProductDetailViewController.State, Never>(PriceComparisonDataPublisher.state)
        self.productList = CurrentValueSubject<[PriceComparisonTableViewCell.State], Never>(PriceComparisonDataPublisher.state.PriceComparisonCellData.cellData)
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

public protocol ProductDetailBuildable: Buildable {
    func build(withListener listener: ProductDetailListener) -> ViewableRouting
}

public final class ProductDetailBuilder: Builder<ProductDetailDependency>, ProductDetailBuildable {
    
    public override init(dependency: ProductDetailDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: ProductDetailListener) -> ViewableRouting {
        let component = ProductDetailComponent(dependency: dependency)
        let viewController = ProductDetailViewController(navigationBarType: .alarm_Setting_Home)
        let interactor = ProductDetailInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        
        let priceViewController = PriceComparisonMoreBuilder(dependency: component)
        
        return ProductDetailRouter(
            interactor: interactor,
            viewController: viewController,
            priceComparisonMoreBuildable: priceViewController
        )
    }
}

