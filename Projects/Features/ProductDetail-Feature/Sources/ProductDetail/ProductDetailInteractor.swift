//
//  Interactor.stencil
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import Foundation
import ModernRIBs
import Combine

protocol ProductDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachPriceComparisonMore()
    func detachPriceComparisonMore()
}

protocol ProductDetailPresentable: Presentable {
    var listener: ProductDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func setCellData(_ data: [PriceComparisonTableViewCell.State])
}

public protocol ProductDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func productDetailDidTapClose()
}

protocol TransportHomeInteractorDependency {
    var productList: CurrentValueSubject<[PriceComparisonTableViewCell.State], Never> { get }
}

final class ProductDetailInteractor: PresentableInteractor<ProductDetailPresentable>, ProductDetailInteractable, ProductDetailPresentableListener {

    weak var router: ProductDetailRouting?
    weak var listener: ProductDetailListener?
    
    private let dependency: TransportHomeInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
    
    init(
        presenter: ProductDetailPresentable,
        dependency: TransportHomeInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        dependency
            .productList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.presenter.setCellData(data)
            }
            .store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func swipeToBack() {
        listener?.productDetailDidTapClose()
    }
    
    func attachMoreView() {
        router?.attachPriceComparisonMore()
    }
    
    func detachMoreView() {
        router?.detachPriceComparisonMore()
    }
}
