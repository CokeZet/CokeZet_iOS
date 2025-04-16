//
//  AdBannerButton.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/5/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit
import Then
import CokeZet_Components
import SwiftUI

final class AdBannerButton: UIButton {
    
    public struct State {
        let descriptText: String
        let priceText: String
    }
    
    // MARK: - UI Components
    private let box = UIView().then {
        $0.isUserInteractionEnabled = false
    }
    
    private let titleStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
        $0.distribution = .fill
    }
    
    private let descriptLabel = ZetLabel(typography: .semiBold(.T16), textColor: .Gray300).then {
        $0.numberOfLines = 2
        $0.lineBreakStrategy = .hangulWordPriority
    }
    
    private let priceStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let priceLabel = ZetLabel(typography: .semiBold(.T18), textColor: .Red500)
    
    private let tooltip = ToolTip()
    
    private let imageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private let shopImageView = UIImageView().then {
        $0.image = CokeZetDesignSystemAsset.icNaver.image
        $0.layer.cornerRadius = Layout.imageSize.height / 2
        $0.clipsToBounds = true
    }
    
    private let arrowImageView = UIImageView().then {
        $0.image = CokeZetDesignSystemAsset.chevronRight.image
    }
    
    // MARK: - Constants
    private enum Layout {
        static let horizontalInset: CGFloat = 20
        static let verticalInset: CGFloat = 24
        static let imageSize: CGSize = CGSize(width: 56, height: 56)
        static let arrowSize: CGSize = CGSize(width: 20, height: 20)
        static let imageStackWidth: CGFloat = 84
        static let titleStackSpacing: CGFloat = 24
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        // 기본 설정
        backgroundColor = .Gray700
        layer.cornerRadius = 16
    }
    
    private func setupLayout() {
        // Add Subviews
        addSubview(box)
        
        // Add Subviews to Box
        [titleStack, imageStackView].forEach {
            box.addSubview($0)
        }
        
        // Add Subviews to Title Stack
        [descriptLabel, priceStackView].forEach {
            titleStack.addArrangedSubview($0)
        }
        
        // Add Subviews to Price Stack
        [priceLabel, tooltip].forEach {
            priceStackView.addArrangedSubview($0)
        }
        
        // Add Subviews to Image Stack
        [shopImageView, arrowImageView].forEach {
            imageStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        // Box Constraints
        box.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(Layout.horizontalInset)
            $0.trailing.equalToSuperview().inset(Layout.horizontalInset)
            $0.top.equalToSuperview().offset(Layout.verticalInset)
            $0.bottom.equalToSuperview().inset(Layout.verticalInset)
        }
        
        // Title Stack Constraints
        titleStack.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        // Image Stack Constraints
        imageStackView.snp.makeConstraints {
            $0.leading.equalTo(titleStack.snp.trailing).offset(Layout.titleStackSpacing)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(Layout.imageStackWidth)
        }
        
        // Shop Image Constraints
        shopImageView.snp.makeConstraints {
            $0.size.equalTo(Layout.imageSize)
        }
        
        // Arrow Image Constraints
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(Layout.arrowSize)
        }
    }
    
    // MARK: - Bind
    public func bind(_ state: State) {
        descriptLabel.text = state.descriptText
        priceLabel.text = state.priceText
    }
}
