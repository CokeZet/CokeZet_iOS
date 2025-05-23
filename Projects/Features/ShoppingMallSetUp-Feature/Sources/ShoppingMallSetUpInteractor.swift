//
//  Interactor.stencil
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs

protocol ShoppingMallSetUpRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ShoppingMallSetUpPresentable: Presentable {
    var listener: ShoppingMallSetUpPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ShoppingMallSetUpListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ShoppingMallSetUpInteractor: PresentableInteractor<ShoppingMallSetUpPresentable>, ShoppingMallSetUpInteractable, ShoppingMallSetUpPresentableListener {

    weak var router: ShoppingMallSetUpRouting?
    weak var listener: ShoppingMallSetUpListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ShoppingMallSetUpPresentable) {
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
}
