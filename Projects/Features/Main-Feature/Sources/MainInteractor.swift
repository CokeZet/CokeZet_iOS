//
//  Interactor.stencil
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ModernRIBs
import Combine
import Foundation
import CokeZet_Core

protocol MainRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func attachProductDetail()
    func deatchProductDetail()
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol MainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func attachAlarm()
    func attachUser()
    func moveToHome()
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable, MainPresentableListener {
    
    weak var router: MainRouting?
    weak var listener: MainListener?
    
    private var cancellables: Set<AnyCancellable>
    
    private let dependency: MainDependency
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    
    init(
        presenter: MainPresentable,
        dependency: MainDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        
        dependency.navigationStream
            .stream
            .receive(on: DispatchQueue.main)
            .sink { [weak self] type in
                print("Main Tabs \(type)")
                if type == .home {
                    self?.router?.deatchProductDetail()
                }
            }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func productDetailAttach() {
        router?.attachProductDetail()
    }
    
    func productDetailDidTapClose() {
        router?.deatchProductDetail()
    }
    
    func alarmButtonTapped() {
        listener?.attachAlarm()
    }
    
    func userButtonTapped() {
        listener?.attachUser()
    }
    
    func homeButtonTapped() {
        dependency.navigationStream.send(.home)
//        listener?.moveToHome()
//        productDetailDidTapClose()
    }
}
