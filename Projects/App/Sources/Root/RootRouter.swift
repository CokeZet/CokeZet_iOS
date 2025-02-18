//
//  RootRouter.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs
import Main_Feature
import CokeZet_Utilities
import CokeZet_Core

protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let mainBuildable: MainBuildable
    private let transitioningDelegate: PushModalPresentationController
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        mainBuildable: MainBuildable
    ) {
        self.transitioningDelegate = PushModalPresentationController()
        self.mainBuildable = mainBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachMain() {
        let mainRouting = mainBuildable.build(withListener: interactor)
        presentWithPushTransition(mainRouting.viewControllable, animated: true)
        attachChild(mainRouting)
    }
    
    private func presentWithPushTransition(_ viewControllable: ViewControllable, animated: Bool) {
        viewControllable.uiviewController.modalPresentationStyle = .custom
        viewControllable.uiviewController.transitioningDelegate = transitioningDelegate
        viewController.present(viewControllable, animated: true, completion: nil)
    }
}
