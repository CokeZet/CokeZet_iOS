//
//  MenuCell.swift
//  Setting-Feature
//
//  Created by 김진우 on 3/12/25.
//

import UIKit
import CokeZet_DesignSystem

// MARK: - MenuCell
class MenuCell: UICollectionViewCell {
    
    // MARK: - UI Components
    private let titleLabel = ZetLabel(typography: .semiBold(.T18), textColor: ZetColor.White.color)
    private let arrowImageView = UIImageView()
    
    struct State {
        let title: String
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
        
        // 타이틀 라벨
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        // 화살표 이미지
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .lightGray
        contentView.addSubview(arrowImageView)
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
    }
    
    // MARK: - Bind
    public func bind(_ state: State) {
        titleLabel.text = state.title
    }
}
