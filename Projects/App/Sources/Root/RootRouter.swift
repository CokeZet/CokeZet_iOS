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
import Foundation

protocol RootInteractable: Interactable, MainListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
    func setViewController(_ viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    private let mainBuildable: MainBuildable
    private var mainRouting: Routing?
    
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
        if mainRouting != nil { return }
        
        let router = mainBuildable.build(withListener: interactor)
        mainRouting = router
        attachChild(router)
        
        viewController.setViewController(router.viewControllable)
    }
}
