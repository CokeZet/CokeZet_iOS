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
import Setting_Feature
import Login_Feature
import MyCardSetUp_Feature
import Nickname_Feature
import ShoppingMallSetUp_Feature
import UIKit

protocol RootInteractable: Interactable,
                           MainListener,
                           SettingListener,
                           LoginListener,
                           SettingListener,
                           NicknameListener,
                           MyCardSetUpListener,
                           ShoppingMallSetUpListener
{
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol RootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
    private let nickNameBuildable: NicknameBuildable
    private var nickNameRouting: Routing?
    
    private let shoppingMallBuildable: ShoppingMallSetUpBuildable
    private var shoppingMallRouting: Routing?
    
    private let cardSetupBuildable: MyCardSetUpBuildable
    private var cardSetupRouting: Routing?
    
    private let loginBuildable: LoginBuildable
    private var loginRouting: Routing?
    
    private let mainBuildable: MainBuildable
    private var mainRouting: Routing?
    
    private let alarmBuildable: Buildable? = nil
    private var alarmRouting: Routing?
    
    private let settingBuildable: SettingBuildable
    private var settingRouting: Routing?
    
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        mainBuildable: MainBuildable,
        settingBuilable: SettingBuildable,
        loginBuildable: LoginBuildable,
        nickNameBuildable: NicknameBuildable,
        shoppingMallBuildable: ShoppingMallSetUpBuildable,
        cardSetupBuildable: MyCardSetUpBuildable
    ) {
        self.nickNameBuildable = nickNameBuildable
        self.shoppingMallBuildable = shoppingMallBuildable
        self.cardSetupBuildable = cardSetupBuildable
        self.mainBuildable = mainBuildable
        self.settingBuildable = settingBuilable
        self.loginBuildable = loginBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachNickName() {
        if nickNameRouting != nil { return }
        
        let router = nickNameBuildable.build(withListener: interactor)
        nickNameRouting = router
        attachChild(router)
        
        viewController.pushViewController(router.viewControllable, animated: true)
    }
    
    func moveToShoppingMallSetup() {
        if shoppingMallRouting != nil { return }
        
        let router = shoppingMallBuildable.build(withListener: interactor)
        shoppingMallRouting = router
        attachChild(router)
        
        viewController.pushViewController(router.viewControllable, animated: true)
    }
    
    func moveToCardSetup() {
        if cardSetupRouting != nil { return }
        
        let router = cardSetupBuildable.build(withListener: interactor)
        cardSetupRouting = router
        attachChild(router)
        
        viewController.pushViewController(router.viewControllable, animated: true)
    }
    
    func firstLoginSetupFinish() {
        detachFirstLoginSetup()
        attachMain()
    }
    
    func detachFirstLoginSetup() {
        guard let nicknameRouter = nickNameRouting,
              let shoppingMallRouting = shoppingMallRouting,
              let cardSetupRouting = cardSetupRouting
        else {
            return
        }
        
        viewController.popToRoot(animated: false)
        
        self.nickNameRouting = nil
        detachChild(nicknameRouter)
        
        self.shoppingMallRouting = nil
        detachChild(shoppingMallRouting)
        
        self.cardSetupRouting = nil
        detachChild(cardSetupRouting)
    }
    
    func moveToHome() {
        viewController.popToRoot(animated: false)
        
        detachUser()
    }
    
    func attachLogin() {
        if loginRouting != nil { return }
        
        let router = loginBuildable.build(withListener: interactor)
        loginRouting = router
        attachChild(router)
        
        viewController.setViewControllers([router.viewControllable])
    }
    
    func detachLogin() {
        guard let router = loginRouting else {
            return
        }
        
        viewController.popViewController(animated: true)
        self.loginRouting = nil
        detachChild(router)
    }
    
    func attachMain() {
        if mainRouting != nil { return }
        
        let view = viewController.uiviewController as! UINavigationController
        view.navigationBar.isHidden = false
        let router = mainBuildable.build(withListener: interactor)
        mainRouting = router
        attachChild(router)
        
        viewController.setViewControllers([router.viewControllable])
    }
    
    func attachAlarm() {
        return
    }
    
    func attachUser() {
        if settingRouting != nil { return }
        
        let router = settingBuildable.build(withListener: interactor)
        settingRouting = router
        attachChild(router)
        
        viewController.pushViewController(router.viewControllable, animated: true)
    }
    
    func detachUser() {
        guard let router = settingRouting else {
            return
        }
        
        viewController.popViewController(animated: true)
        self.settingRouting = nil
        detachChild(router)
    }
    
}
