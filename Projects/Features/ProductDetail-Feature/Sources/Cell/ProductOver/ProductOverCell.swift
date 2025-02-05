//
//  ProductOverView.swift
//  CokeZet-UI
//
//  Created by 김진우 on 1/22/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit
import Then
import CokeZet_Components
import SwiftUI

public class ProductOverCell: UICollectionViewCell {
    
    // MARK: - UI Components
    private let infomationView = ProductInfomationView(frame: .zero)
    
    private let buyButton = ZetRoundButton(buttonState: .Primary).then {
        $0.setTitle("최저가로 구매하기", for: .normal)
        let action = UIAction(handler: { _ in
            print("ProductOverView Buy Button clicked!")
        })
        $0.addAction(action, for: .touchUpInside)
    }
    
    private let adBannerButton = AdBannerButton(frame: .zero).then {
        let action = UIAction(handler: { _ in
            print("Banner Button clicked!")
        })
        $0.addAction(action, for: .touchUpInside)
    }
    
    // MARK: - Constants
    private enum Layout {
        static let cornerRadius: CGFloat = 32
        static let horizontalInset: CGFloat = 20
        static let verticalSpacing: CGFloat = 32
        static let adBannerTopSpacing: CGFloat = 24
        static let bottomInset: CGFloat = 24
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupConstraints()
        applyTopCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    private func setupLayout() {
        [infomationView, buyButton, adBannerButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        infomationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Layout.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(Layout.horizontalInset)
        }
        
        buyButton.snp.makeConstraints {
            $0.top.equalTo(infomationView.snp.bottom).offset(Layout.verticalSpacing)
            $0.leading.trailing.equalToSuperview().inset(Layout.horizontalInset)
        }
        
        adBannerButton.snp.makeConstraints {
            $0.top.equalTo(buyButton.snp.bottom).offset(Layout.adBannerTopSpacing)
            $0.leading.trailing.equalToSuperview().inset(Layout.horizontalInset)
            $0.bottom.equalToSuperview().inset(Layout.bottomInset)
        }
    }
    
    private func applyTopCornerRadius() {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight], // 상단 좌우만 둥글게
            cornerRadii: CGSize(width: Layout.cornerRadius, height: Layout.cornerRadius)
        )
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

struct ProductOverCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> ProductOverCell {
        let cell = ProductOverCell()
        cell.backgroundColor = ZetColor.Gray800.color
        return cell
    }

    func updateUIView(_ uiView: ProductOverCell, context: Context) {}
}

@available(iOS 17.0, *)
#Preview {
    ProductOverCellPreview()
        .frame(width: 375, height: 534)
}
