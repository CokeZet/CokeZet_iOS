//
//  RootInteractor.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs
import CokeZet_Core
import Combine
import Foundation
import AuthenticationServices
import CokeZet_Network

protocol RootRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachNickName()
    func moveToShoppingMallSetup()
    func moveToCardSetup()
    func firstLoginSetupFinish()
    
    func attachLogin()
    func attachMain()
    func attachAlarm()
    func attachUser()
    func detachLogin()
    func detachUser()
    func moveToHome()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
    
    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
    
    private lazy var appleLoginManager = AppleLoginManager(delegate: self)

    
    weak var router: RootRouting?
    weak var listener: RootListener?

    private let dependency: RootDependency
    
    private var cancellables: Set<AnyCancellable>
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: RootPresentable,
        dependency: RootDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        router?.attachLogin()
        
        dependency.navigationStream
            .stream
            .receive(on: DispatchQueue.main)
            .sink { [weak self] type in
                print("Root Tabs \(type)")
                if type == .home {
                    self?.router?.moveToHome()
                    self?.dependency.navigationStream.stream.value = .none
                }
            }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    /// 최초 로그인 시 설정
    ///
    
    func continueToNickname() {
        router?.moveToShoppingMallSetup()
    }
    
    func continueToShoppingMall() {
        router?.moveToCardSetup()
    }
    
    func continueToMyCard() {
        router?.firstLoginSetupFinish()
    }
    
    /// 로그인 관련 로직
    func loginSuccess() {
        router?.attachNickName()
    }
    
    func loginFailure() {
        router?.attachMain()
    }
    
    func detachLogin() {
        router?.attachMain()
    }
    
    func appleLogin() {
        appleLoginManager.startAppleLogin()
    }
    
    /// NavigationBar 이동 로직
    func attachAlarm() {
        router?.attachAlarm()
    }
    
    func attachUser() {
        router?.attachUser()
    }
    
    func detachSetting() {
        router?.detachUser()
    }
    
    func moveToHome() {
        dependency.navigationStream.send(.home)
    }
    
}

extension RootInteractor: AppleLoginManagerDelegate {
    func didCompleteAppleLogin(userId: String, email: String?, token: String) async throws {
//        listener?.didLoginSuccessfully(userId: userId, email: email)
        print("Login Success")
        let _: [Post] = try await NetworkService.shared.requestAsync(endpoint: LoginEndpoint.login(token: token))
    }
    
    func didFailAppleLogin() {
//        listener?.didCancelLogin()
        print("Login Failed")
    }
}
