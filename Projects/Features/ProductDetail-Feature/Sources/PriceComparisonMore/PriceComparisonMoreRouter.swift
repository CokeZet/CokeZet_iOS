//
//  PriceComparisonMoreRouter.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/18/25.
//

import ModernRIBs

protocol PriceComparisonMoreInteractable: Interactable {
    var router: PriceComparisonMoreRouting? { get set }
    var listener: PriceComparisonMoreListener? { get set }
}

protocol PriceComparisonMoreViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class PriceComparisonMoreRouter: ViewableRouter<PriceComparisonMoreInteractable, PriceComparisonMoreViewControllable>, PriceComparisonMoreRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: PriceComparisonMoreInteractable, viewController: PriceComparisonMoreViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
