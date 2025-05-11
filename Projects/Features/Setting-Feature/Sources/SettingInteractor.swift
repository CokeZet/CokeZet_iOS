import ModernRIBs
import Combine
import Foundation
import CokeZet_Core

protocol SettingRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SettingPresentable: Presentable {
    var listener: SettingPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol SettingListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func detachSetting()
    func attachAlarm()
    func moveToHome()
    func deleteProfile()
}

final class SettingInteractor: PresentableInteractor<SettingPresentable>, SettingInteractable, SettingPresentableListener {

    weak var router: SettingRouting?
    weak var listener: SettingListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SettingPresentable) {
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
    
    func detachSetting() {
        listener?.detachSetting()
    }
    
    func alarmButtonTapped() {
        listener?.attachAlarm()
    }
    
    func homeButtonTapped() {
        listener?.moveToHome()
    }
    
    func deleteProfile() {
        listener?.deleteProfile()
    }
}
