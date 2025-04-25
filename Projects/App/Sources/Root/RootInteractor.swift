//
//  RootInteractor.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import Combine
import Foundation
import AuthenticationServices

import ModernRIBs

import CokeZet_Core
import CokeZet_Network
import CokeZet_Configurations

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
        Task { @MainActor in
            do {
                try await tryLocalTokenLogin()
            } catch NetworkError.tokenExpired(_) {
                print("Access Token Expired")
                
                do {
                    try await tryRefreshToken()
                } catch {
                    router?.attachLogin()
                }
            } catch {
                router?.attachLogin()
            }
        }
        
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
    func firstLoginSuccess() {
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
    
    func guestLogin() {
        Task {
            try await tryGuestLogin()
        }
    }
}

// MARK: - 로그인 로직
extension RootInteractor {
    @MainActor
    func tryGuestLogin() async throws {
        let guest: AuthResponse<AuthData> = try await NetworkService.shared.requestAsync(endpoint: LoginEndpoint.guestLogin)
        
        guard let data = guest.data else { return }
        
        AuthManager.shared.saveAuthData(accessToken: data.accessToken, refreshToken: data.refreshToken ?? "", user: data.user)
        
        detachLogin()
    }
    
    @MainActor
    func tryLocalTokenLogin() async throws {
        print("Try Access Token Login")
        
        let profile: AuthResponse<Profile> = try await NetworkService.shared.requestAsync(endpoint: ProfileEndpoint.getProfile)
        guard let profile_data = profile.data else { return }
        
        if !profile_data.profileComplete {
            firstLoginSuccess()
        } else {
            router?.detachLogin()
        }
    }
    
    @MainActor
    func tryRefreshToken() async throws {
        print("Try Access Token Refresh")
        
        guard let token = AuthManager.shared.getRefreshToken() else { throw NetworkError.refreshTokenFailed(statusCode: 401) }
        let refresh: AuthResponse<RefreshTokenResponse> = try await NetworkService.shared.requestAsync(endpoint: LoginEndpoint.refresh(refreshToken: token))
        
        guard let data = refresh.data else { throw NetworkError.invalidResponse }
        
        AuthManager.shared.updateTokens(accessToken: data.accessToken, refreshToken: data.refreshToken)
        
        try await tryLocalTokenLogin()
    }
}

// MARK: - 애플 로그인 로직
extension RootInteractor: AppleLoginManagerDelegate {
    func didCompleteAppleLogin(userId: String, email: String?, token: String) async throws {
        print("Login Success")
        let data: AuthResponse<AuthData> = try await NetworkService.shared.requestAsync(endpoint: LoginEndpoint.login(token: token))
        
        guard let data = data.data, let refreshToken = data.refreshToken else { return }
        
        AuthManager.shared.saveAuthData(accessToken: data.accessToken, refreshToken: refreshToken, user: data.user)
        
        print(AuthManager.shared.getCurrentUser() ?? "Not found User")
        
        let profile: AuthResponse<Profile> = try await NetworkService.shared.requestAsync(endpoint: ProfileEndpoint.getProfile)
        
        guard let profile_data = profile.data else { return }
        
        print(profile)
        
        Task { @MainActor in
            if data.newUser || !profile_data.profileComplete {
                firstLoginSuccess()
            } else {
                detachLogin()
            }
        }
    }
    
    func didFailAppleLogin() {
        //        listener?.didCancelLogin()
        print("APPLE Login Failed")
    }
}
