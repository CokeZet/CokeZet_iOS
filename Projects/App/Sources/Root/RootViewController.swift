//
//  RootViewController.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs
import UIKit
import Then
import SnapKit
import CokeZet_DesignSystem

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func backButtonTaped()
}

final class RootViewController: UINavigationController, RootPresentable, RootViewControllable {
    let label: UILabel = UILabel().then {
        $0.text = "안녕하세요"
    }
    
    weak var listener: RootPresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ZetColor.Black.color
    }
    
    @objc func backButtonTaped() {
        listener?.backButtonTaped()
    }
    
    func setupViews() {
        self.view.addSubview(label)
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func setViewController(_ viewController: ViewControllable) {
        let viewController = viewController.uiviewController
        super.pushViewController(viewController, animated: true)
    }
}
