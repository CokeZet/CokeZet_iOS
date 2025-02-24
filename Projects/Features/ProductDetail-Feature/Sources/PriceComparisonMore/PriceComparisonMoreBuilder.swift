//
//  PriceComparisonMoreBuilder.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/18/25.
//

import ModernRIBs
import Combine

public protocol PriceComparisonMoreDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var productList: CurrentValueSubject<[PriceComparisonTableViewCell.State], Never> { get }
}

final class PriceComparisonMoreComponent: Component<PriceComparisonMoreDependency>, PriceComparisonMoreInteractorDependency {
    var productList: CurrentValueSubject<[PriceComparisonTableViewCell.State], Never> { dependency.productList }
    
    override init(
        dependency: PriceComparisonMoreDependency
    ) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

public protocol PriceComparisonMoreBuildable: Buildable {
    func build(withListener listener: PriceComparisonMoreListener) -> PriceComparisonMoreRouting
}

final class PriceComparisonMoreBuilder: Builder<PriceComparisonMoreDependency>, PriceComparisonMoreBuildable {

    override init(dependency: PriceComparisonMoreDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: PriceComparisonMoreListener) -> PriceComparisonMoreRouting {
        let component = PriceComparisonMoreComponent(dependency: dependency)
        let viewController = PriceComparisonMoreViewController()
        let interactor = PriceComparisonMoreInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        
        return PriceComparisonMoreRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
