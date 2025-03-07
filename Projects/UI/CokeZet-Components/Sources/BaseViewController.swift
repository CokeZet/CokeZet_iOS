//
//  BaseViewController.swift
//  CokeZet-Core
//
//  Created by 김진우 on 3/7/25.
//

import UIKit
import CokeZet_DesignSystem
import SnapKit

protocol BaseViewControllerDelegate {
    func backButtonTapped()
    func alarmButtonTapped()
    func userButtonTapped()
}

/// 구현 시 필요에 따라 left Item, alarm, user func를 override 하여, 수정해야함.
open class BaseViewController: UIViewController, BaseViewControllerDelegate {
    open var navigationBarType: NavigationBarType
    
    lazy var leftItem: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(CokeZetDesignSystemAsset.icMainLogo.image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // SnapKit을 이용해 버튼의 크기를 강제로 32x32로 설정
        button.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        if navigationBarType == .Back {
            return UIBarButtonItem(
                image: CokeZetDesignSystemAsset.chevronLeft.image.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(backButtonTapped)
            )
        }
        
        return UIBarButtonItem(customView: button)
    }()
    
    // 오른쪽 아이템: icBell 아이콘
    lazy var alarmItem: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(CokeZetDesignSystemAsset.icBell.image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(alarmButtonTapped), for: .touchUpInside)
        
        // SnapKit을 이용해 버튼의 크기를 강제로 32x32로 설정
        button.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        return UIBarButtonItem(customView: button)
    }()
    
    // 오른쪽 아이템: User 아이콘
    lazy var userItem: UIBarButtonItem = {
        let button = UIButton(type: .system)
        button.setImage(CokeZetDesignSystemAsset.icUser.image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        return UIBarButtonItem(customView: button)
    }()
    
    public init(navigationBarType: NavigationBarType) {
        self.navigationBarType = navigationBarType
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
    }
    
    func setupNavigationItems() {
        
        // 왼쪽 아이템: 로고 이미지 혹은 뒤로가기 버튼
        navigationItem.leftBarButtonItem = leftItem
        
        // fixedSpace 아이템 생성 (8px 여백)
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 8
        
        // rightBarButtonItems 배열의 순서: 오른쪽에서 왼쪽으로 표시됨
        navigationItem.rightBarButtonItems = [userItem, fixedSpace, alarmItem]
    }
    
    /// Navigation Controller에서 이전 화면으로 돌아가는 액션
    @objc open func backButtonTapped() {
        print("Back Button Tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc open func alarmButtonTapped() {
        print("alarmButton Tapped")
    }
    
    @objc open func userButtonTapped() {
        print("userButton Tapped")
    }
    
}
