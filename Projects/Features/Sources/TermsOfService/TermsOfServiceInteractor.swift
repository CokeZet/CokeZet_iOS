//
//  TermsOfServiceInteractor.swift
//  Features
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs

public protocol TermsOfServiceRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TermsOfServicePresentable: Presentable {
    var listener: TermsOfServicePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol TermsOfServiceListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class TermsOfServiceInteractor: PresentableInteractor<TermsOfServicePresentable>, TermsOfServiceInteractable, TermsOfServicePresentableListener {

    weak var router: TermsOfServiceRouting?
    weak var listener: TermsOfServiceListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: TermsOfServicePresentable) {
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
