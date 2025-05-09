//
//  Interactor.stencil
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs
import CokeZet_Network
import CokeZet_Configurations

protocol MyCardSetUpRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol MyCardSetUpPresentable: Presentable {
    var listener: MyCardSetUpPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol MyCardSetUpListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func continueToMyCard()
}

final class MyCardSetUpInteractor: PresentableInteractor<MyCardSetUpPresentable>, MyCardSetUpInteractable, MyCardSetUpPresentableListener {
    
    weak var router: MyCardSetUpRouting?
    weak var listener: MyCardSetUpListener?

    private let dependency: MyCardSetUpDependency
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(
        presenter: MyCardSetUpPresentable,
        dependency: MyCardSetUpDependency
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
    
    func continueToMyCard(_ cardList: [Int]) {
        dependency.userSetting.cardCompanyIds = cardList
        print("UserSetting CardCompanyIds Update: \(dependency.userSetting)")
        _ = UserSettingsManager.shared.saveSettings(dependency.userSetting)
        
        guard let user = UserSettingsManager.shared.loadSettings() else { return }
        Task { @MainActor in
            let result: AuthResponse<AuthData> = try await NetworkService.shared.requestAsync(endpoint: ProfileEndpoint.updateProfile(user: user))
            listener?.continueToMyCard()
        }
    }
}
