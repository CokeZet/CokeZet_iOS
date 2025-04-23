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
}

final class RootViewController: UINavigationController, RootPresentable, RootViewControllable {
    
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
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.isTranslucent = false
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
    }
}
