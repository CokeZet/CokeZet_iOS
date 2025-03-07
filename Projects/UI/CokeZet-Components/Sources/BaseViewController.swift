//
//  BaseViewController.swift
//  CokeZet-Core
//
//  Created by 김진우 on 3/7/25.
//

import UIKit
import CokeZet_DesignSystem
import SnapKit

open class BaseViewController: UIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
    }
    
    func setupNavigationItems() {
        
        // 왼쪽 아이템: 로고 이미지
        let leftItem: UIBarButtonItem = {
            let button = UIButton(type: .system)
            button.setImage(CokeZetDesignSystemAsset.icMainLogo.image.withRenderingMode(.alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
            
            // SnapKit을 이용해 버튼의 크기를 강제로 32x32로 설정
            button.snp.makeConstraints { make in
                make.width.height.equalTo(32)
            }
            
            return UIBarButtonItem(customView: button)
        }()
        
        navigationItem.leftBarButtonItem = leftItem
        
        // 오른쪽 아이템: icBell 아이콘
        let alarmItem: UIBarButtonItem = {
            let button = UIButton(type: .system)
            button.setImage(CokeZetDesignSystemAsset.icBell.image.withRenderingMode(.alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            
            // SnapKit을 이용해 버튼의 크기를 강제로 32x32로 설정
            button.snp.makeConstraints { make in
                make.width.height.equalTo(32)
            }
            
            return UIBarButtonItem(customView: button)
        }()
        
        // 오른쪽 아이템: User 아이콘
        let settingItem: UIBarButtonItem = {
            let button = UIButton(type: .system)
            button.setImage(CokeZetDesignSystemAsset.icUser.image.withRenderingMode(.alwaysOriginal), for: .normal)
            button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            
            button.snp.makeConstraints { make in
                make.width.height.equalTo(32)
            }
            
            return UIBarButtonItem(customView: button)
        }()
        
        // fixedSpace 아이템 생성 (8px 여백)
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 8
        
        // rightBarButtonItems 배열의 순서: 오른쪽에서 왼쪽으로 표시됨
        navigationItem.rightBarButtonItems = [settingItem, fixedSpace, alarmItem]
    }
    
    /// Navigation Controller에서 이전 화면으로 돌아가는 액션
    @objc open func backButtonTapped() {
        print("Back Button Tapped")
        navigationController?.popViewController(animated: true)
    }
    
    /// 아이콘 탭 액션 (예제에서는 동일한 함수 연결)
    @objc func saveButtonTapped() {
        print("Save tapped")
    }
}
