//
//  TermsOfServiceRouter.swift
//  Features
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs

protocol TermsOfServiceInteractable: Interactable {
    var router: TermsOfServiceRouting? { get set }
    var listener: TermsOfServiceListener? { get set }
}

protocol TermsOfServiceViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TermsOfServiceRouter: ViewableRouter<TermsOfServiceInteractable, TermsOfServiceViewControllable>, TermsOfServiceRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TermsOfServiceInteractable, viewController: TermsOfServiceViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
