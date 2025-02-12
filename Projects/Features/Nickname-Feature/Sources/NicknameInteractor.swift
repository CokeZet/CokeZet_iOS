//
//  Interactor.stencil
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs

protocol NicknameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol NicknamePresentable: Presentable {
    var listener: NicknamePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol NicknameListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class NicknameInteractor: PresentableInteractor<NicknamePresentable>, NicknameInteractable, NicknamePresentableListener {

    weak var router: NicknameRouting?
    weak var listener: NicknameListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: NicknamePresentable) {
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
