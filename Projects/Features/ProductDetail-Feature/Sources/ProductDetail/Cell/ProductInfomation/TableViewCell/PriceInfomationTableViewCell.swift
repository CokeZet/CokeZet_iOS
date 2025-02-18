//
//  PriceInfomationTableViewCell.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/18/25.
//

import UIKit
import CokeZet_DesignSystem

final class PriceInfomationTableViewCell: UITableViewCell {
    // 상단 라인
    private let topBorder: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.Gray700.cgColor // 선 색상
        return layer
    }()
    
    // 하단 라인
    private let bottomBorder: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.Gray700.cgColor // 선 색상
        return layer
    }()
    
    // 하단 라인
    private let centerBorder: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.Gray700.cgColor // 선 색상
        return layer
    }()
    
    private let stackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 16
    }
    
    private let typeLabel: ZetLabel = ZetLabel(typography: .semiBold(.T14), textColor: .Gray500)
    
    private let describeLabel: ZetLabel = ZetLabel(typography: .semiBold(.T14), textColor: .Gray500)
    
    private var _borderFlag: BorderType = .both
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBorders()
        setupLayout()
        makeConstraints()
        addConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 셀의 레이아웃이 변경될 때마다 호출됨
    override func layoutSubviews() {
        super.layoutSubviews()
        let borderWidth: CGFloat = 1 // 선 두께
        
        switch _borderFlag {
        case .top:
            topBorder.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: borderWidth)
        case .bottom:
            bottomBorder.frame = CGRect(x: 0, y: contentView.bounds.height - borderWidth, width: contentView.bounds.width, height: borderWidth)
        case .both:
            topBorder.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: borderWidth)
            bottomBorder.frame = CGRect(x: 0, y: contentView.bounds.height - borderWidth, width: contentView.bounds.width, height: borderWidth)
        }
        
        centerBorder.frame = CGRect(x: 72, y: 0, width: borderWidth, height: self.bounds.height)
    }
    
    public func borderSetup(_ borderFlag: BorderType) {
        self._borderFlag = borderFlag
        layoutIfNeeded()
    }
    
    /// 상단/하단 레이어를 추가하는 함수
    private func setupBorders() {
        [topBorder, bottomBorder, centerBorder].forEach {
            layer.addSublayer($0)
        }
    }
    
    private func setupLayout() {
        addSubview(stackView)
        
        [typeLabel, describeLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func makeConstraints() {
        stackView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(4)
        }
        
        typeLabel.snp.makeConstraints {
            $0.width.equalTo(72)
        }
    }
    
    private func addConfigure() {
        typeLabel.text = "식품 유형"
        describeLabel.text = "음료"
        selectionStyle = .none
        backgroundColor = .clear
    }
}
