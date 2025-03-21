//
//  VersionFooterView.swift
//  Setting-Feature
//
//  Created by 김진우 on 3/12/25.
//

import UIKit
import CokeZet_DesignSystem

class VersionFooterView: UICollectionReusableView {
    
    // MARK: - UI Components
    private let versionLabel = ZetLabel(typography: .medium(.T12), textColor: ZetColor.Gray500.color)
    
    struct State {
        let version: String
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
        addSubview(versionLabel)
        
        versionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        }
    }
    
    public func bind(_ state: State) {
        versionLabel.text = "버전정보 " + state.version
    }
}
