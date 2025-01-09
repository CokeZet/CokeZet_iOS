//
//  RootRouter.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs
import Features

protocol RootInteractable: Interactable {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    // TODO: Constructor inject child builder protocols to allow building children.
    override init(
        interactor: RootInteractable,
        viewController: RootViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
