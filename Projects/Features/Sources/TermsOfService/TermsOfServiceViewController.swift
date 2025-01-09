//
//  TermsOfServiceViewController.swift
//  Features
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs
import UIKit

import SnapKit
import Then

protocol TermsOfServicePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class TermsOfServiceViewController: UIViewController, TermsOfServicePresentable, TermsOfServiceViewControllable {

    weak var listener: TermsOfServicePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
