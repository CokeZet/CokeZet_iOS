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

public protocol ShoppingMallSetUpListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func continueToShoppingMall()
}

final class ShoppingMallSetUpInteractor: PresentableInteractor<ShoppingMallSetUpPresentable>, ShoppingMallSetUpInteractable, ShoppingMallSetUpPresentableListener {
    
    
    weak var router: ShoppingMallSetUpRouting?
    weak var listener: ShoppingMallSetUpListener?

    private let dependency: ShoppingMallSetUpDependency
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: ShoppingMallSetUpPresentable,
        dependency: ShoppingMallSetUpDependency
    ) {
        self.dependency = dependency
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
    
    func continueToShoppingMall(_ commerceType: [Int]) {
        dependency.userSetting.commerceIds = commerceType
        print("UserSetting Commerce Update: \(dependency.userSetting)")
        listener?.continueToShoppingMall()
    }
}
