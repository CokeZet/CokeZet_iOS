//
//  PriceComparisonMoreInteractor.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/18/25.
//

import ModernRIBs

public protocol PriceComparisonMoreRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol PriceComparisonMorePresentable: Presentable {
    var listener: PriceComparisonMorePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol PriceComparisonMoreListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func detachMoreView()
}

final class PriceComparisonMoreInteractor: PresentableInteractor<PriceComparisonMorePresentable>, PriceComparisonMoreInteractable, PriceComparisonMorePresentableListener {

    weak var router: PriceComparisonMoreRouting?
    weak var listener: PriceComparisonMoreListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: PriceComparisonMorePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func closeAction() {
        listener?.detachMoreView()
    }
}
