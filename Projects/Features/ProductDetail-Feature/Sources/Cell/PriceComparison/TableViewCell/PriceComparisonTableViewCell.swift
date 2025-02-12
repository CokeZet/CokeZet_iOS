//
//  PriceComparisonTableViewCell.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/12/25.
//

import UIKit
import CokeZet_DesignSystem

final class PriceComparisonTableViewCell: UITableViewCell {
    private let leftStackView: UIStackView = UIStackView(frame: .zero).then {
        $0.axis = .horizontal
        $0.spacing = 14
        $0.alignment = .center
    }
    
    private let companyImageView: ChoiceView = ChoiceView().then {
        $0.setImage(CokeZetDesignSystemAsset.icBc.image)
    }
    
    private let totalPriceLabel: ZetLabel = ZetLabel(typography: .T18, textColor: .White).then {
        $0.text = "16900".formatWithComma() + "원"
    }
    
    private let rightStackView: UIStackView = UIStackView(frame: .zero).then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .trailing
    }
    
    private let cardPriceLabel: ZetLabel = ZetLabel(typography: .T14, textColor: .Gray500).then {
        $0.text = "신한카드 " + "18200".formatWithComma() + "원"
    }
    
    private let shippingFeeLabel: ZetLabel = ZetLabel(typography: .T14, textColor: .Gray500).then {
        $0.text = "배송비 " + "3000".formatWithComma() + "원"
    }
    
    // MARK: - Constants
    private enum Layout {
        static let topPadding: CGFloat = 12
        static let leftPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 12
        static let rightPadding: CGFloat = 12
        static let imageViewSize: CGSize = CGSize(width: 48, height: 48)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        makeConstraints()
        addConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    private func setupLayout() {
        [leftStackView, rightStackView].forEach {
            contentView.addSubview($0)
        }
        
        [companyImageView, totalPriceLabel].forEach {
            leftStackView.addArrangedSubview($0)
        }
        
        [cardPriceLabel, shippingFeeLabel].forEach {
            rightStackView.addArrangedSubview($0)
        }
    }
    
    private func makeConstraints() {
        leftStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Layout.topPadding)
            $0.leading.equalToSuperview().offset(Layout.leftPadding)
            $0.bottom.equalToSuperview().inset(Layout.bottomPadding)
        }
        
        rightStackView.snp.makeConstraints {
            $0.centerY.equalTo(leftStackView)
            $0.trailing.equalToSuperview().inset(Layout.rightPadding)
        }
        
        companyImageView.snp.makeConstraints {
            $0.size.equalTo(Layout.imageViewSize)
        }
    }
    
    private func addConfigure() {
        backgroundColor = .clear
        contentView.backgroundColor = .Gray600
        contentView.layer.cornerRadius = 8
        selectionStyle = .none
    }
}
