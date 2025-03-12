//
//  ProfileHeaderView.swift
//  Setting-Feature
//
//  Created by 김진우 on 3/12/25.
//

import UIKit
import CokeZet_DesignSystem

// MARK: - ProfileHeaderView
class ProfileHeaderView: UICollectionReusableView {
    
    // MARK: - UI Components
    private let profileImageView = UIImageView()
    private let userNameLabel = ZetLabel(typography: .bold(.T16), textColor: ZetColor.White.color)
    private let sirLabel = ZetLabel(typography: .bold(.T16), textColor: ZetColor.White.color.withAlphaComponent(0.5))
    private let userMessageLabel = ZetLabel(typography: .medium(.T16), textColor: ZetColor.White.color.withAlphaComponent(0.9))
    
    
    struct State {
        let userName: String
    }
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = ZetColor.Gray800.color
        
        // 프로필 이미지
        profileImageView.backgroundColor = .white
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        addSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        // 사용자 이름 라벨
        addSubview(userNameLabel)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(12)
        }
        
        // 님 라벨
        sirLabel.text = "님"
        addSubview(sirLabel)
        
        sirLabel.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(2)
            $0.centerY.equalTo(userNameLabel)
        }
        
        // 사용자 메시지 라벨
        userMessageLabel.text = "오늘도 시원한 콜라 한 잔 하셨나요?"
        addSubview(userMessageLabel)
        
        userMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(4)
            make.left.equalTo(userNameLabel)
        }
    }
    
    public func bind(_ state: State) {
        userNameLabel.text = state.userName
    }
}
