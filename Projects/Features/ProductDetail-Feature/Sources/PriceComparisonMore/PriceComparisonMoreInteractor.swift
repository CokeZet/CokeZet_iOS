//
//  PriceComparisonMoreInteractor.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/18/25.
//

import Foundation
import ModernRIBs
import Combine

public protocol PriceComparisonMoreRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol PriceComparisonMorePresentable: Presentable {
    var listener: PriceComparisonMorePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setPriceComparisonData(_ data: [PriceComparisonTableViewCell.State])
}

public protocol PriceComparisonMoreListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func detachMoreView()
}

protocol PriceComparisonMoreInteractorDependency {
    var productList: CurrentValueSubject<[PriceComparisonTableViewCell.State], Never> { get }
}

final class PriceComparisonMoreInteractor: PresentableInteractor<PriceComparisonMorePresentable>, PriceComparisonMoreInteractable, PriceComparisonMorePresentableListener {

    weak var router: PriceComparisonMoreRouting?
    weak var listener: PriceComparisonMoreListener?
    
    private let dependency: PriceComparisonMoreInteractorDependency
    
    private var cancellables: Set<AnyCancellable>

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: PriceComparisonMorePresentable,
         dependency: PriceComparisonMoreInteractorDependency) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency
            .productList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.presenter.setPriceComparisonData(data)
            }
            .store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func closeAction() {
        listener?.detachMoreView()
    }
}
