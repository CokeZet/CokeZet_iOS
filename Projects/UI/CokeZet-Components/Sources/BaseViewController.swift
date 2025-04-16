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
    
    private func setupNavigationItems() {
        var rightItemlist: [UIBarButtonItem] = []
        let leftItem = makeLeftButtonItem()
        // 왼쪽 아이템: 로고 이미지 혹은 뒤로가기 버튼
        navigationItem.leftBarButtonItem = leftItem
        
        // fixedSpace 아이템 생성 (8px 여백)
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 8
        
        switch navigationBarType {
        case .main:
            rightItemlist += [makeUserButtonItem()]
            rightItemlist += [makeAlarmButtonItem()]
        case .alarm_Setting_Home:
            rightItemlist += [makeHomeButtonItem()]
            rightItemlist += [makeUserButtonItem()]
            rightItemlist += [makeAlarmButtonItem()]
        case .alarm_Home:
            rightItemlist += [makeHomeButtonItem()]
            rightItemlist += [makeAlarmButtonItem()]
        }
        
        // rightBarButtonItems 배열의 순서: 오른쪽에서 왼쪽으로 표시됨
        navigationItem.rightBarButtonItems = rightItemlist
    }
    
    private func makeLeftButtonItem() -> UIBarButtonItem {
        let leftButton = UIButton(type: .system)
        leftButton.setImage(CokeZetDesignSystemAsset.icMainLogo.image.withRenderingMode(.alwaysOriginal), for: .normal)
        leftButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        // SnapKit을 이용해 버튼의 크기를 강제로 32x32로 설정
        leftButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        if navigationBarType != .main {
            return UIBarButtonItem(
                image: CokeZetDesignSystemAsset.chevronLeft.image.withRenderingMode(.alwaysOriginal),
                style: .plain,
                target: self,
                action: #selector(backButtonTapped)
            )
        }
        
        return UIBarButtonItem(customView: leftButton)
    }
    
    private func makeAlarmButtonItem() -> UIBarButtonItem {
        let alarmButton = UIButton(type: .system)
        alarmButton.setImage(CokeZetDesignSystemAsset.icBell.image.withRenderingMode(.alwaysOriginal), for: .normal)
        alarmButton.addTarget(self, action: #selector(alarmButtonTapped), for: .touchUpInside)
        
        // SnapKit을 이용해 버튼의 크기를 강제로 32x32로 설정
        alarmButton.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        return UIBarButtonItem(customView: alarmButton)
    }
    
    private func makeUserButtonItem() -> UIBarButtonItem {
        let userButton = UIButton(type: .system)
        userButton.setImage(CokeZetDesignSystemAsset.icUser.image.withRenderingMode(.alwaysOriginal), for: .normal)
        userButton.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
        
        userButton.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        return UIBarButtonItem(customView: userButton)
    }
    
    private func makeHomeButtonItem() -> UIBarButtonItem {
        let userButton = UIButton(type: .system)
        userButton.setImage(CokeZetDesignSystemAsset.icHome.image.withRenderingMode(.alwaysOriginal), for: .normal)
        userButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        
        userButton.snp.makeConstraints { make in
            make.width.height.equalTo(32)
        }
        
        return UIBarButtonItem(customView: userButton)
    }
    
    /// Navigation Controller에서 이전 화면으로 돌아가는 액션
    @objc open func backButtonTapped() {
        print("Back Button Tapped")
    }
    
    @objc open func alarmButtonTapped() {
        print("alarmButton Tapped")
    }
    
    @objc open func userButtonTapped() {
        print("userButton Tapped")
    }
    
    @objc open func homeButtonTapped() {
        print("homeButton Tapped")
    }
    
}
