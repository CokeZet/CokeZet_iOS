//
//  PriceComparisonTableViewCell.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/12/25.
//

import UIKit
import CokeZet_DesignSystem

final class PriceComparisonTableViewCell: UITableViewCell {
    
    // MARK: - UI Components
    
    /// 왼쪽 스택뷰: 회사 이미지와 총 가격 라벨을 포함
    private let leftStackView: UIStackView = UIStackView(frame: .zero).then {
        $0.axis = .horizontal
        $0.spacing = 14
        $0.alignment = .center
    }
    
    /// 회사 이미지 뷰
    private let companyImageView: UIImageView = UIImageView(frame: .zero)
    
    /// 총 가격 라벨
    private let totalPriceLabel: ZetLabel = ZetLabel(typography: .semiBold(.T18), textColor: .White).then {
        $0.text = "16900".formatWithComma() + "원"
    }
    
    /// 오른쪽 스택뷰: 카드 가격과 배송비 라벨을 포함
    private let rightStackView: UIStackView = UIStackView(frame: .zero).then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .trailing
    }
    
    /// 카드 가격 라벨
    private let cardPriceLabel: ZetLabel = ZetLabel(typography: .semiBold(.T14), textColor: .Gray500).then {
        $0.text = "신한카드 " + "18200".formatWithComma() + "원"
    }
    
    /// 배송비 라벨
    private let shippingFeeLabel: ZetLabel = ZetLabel(typography: .semiBold(.T14), textColor: .Gray500).then {
        $0.text = "배송비 " + "3000".formatWithComma() + "원"
    }
    
    // MARK: - Constants
    
    /// 레이아웃 상수 정의
    private enum Layout {
        static let topPadding: CGFloat = 12
        static let leftPadding: CGFloat = 12
        static let bottomPadding: CGFloat = 12
        static let rightPadding: CGFloat = 12
        static let imageViewSize: CGSize = CGSize(width: 48, height: 48)
    }
    
    // MARK: - State
    
    /// 셀의 상태를 나타내는 구조체
    public struct State {
        let image: UIImage
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        makeConstraints()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 셀의 contentView에 패딩 적용
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    // MARK: - Setup Methods
    
    /// 레이아웃 구성
    private func setupLayout() {
        // 스택뷰를 contentView에 추가
        [leftStackView, rightStackView].forEach {
            contentView.addSubview($0)
        }
        
        // 왼쪽 스택뷰에 컴포넌트 추가
        [companyImageView, totalPriceLabel].forEach {
            leftStackView.addArrangedSubview($0)
        }
        
        // 오른쪽 스택뷰에 컴포넌트 추가
        [cardPriceLabel, shippingFeeLabel].forEach {
            rightStackView.addArrangedSubview($0)
        }
    }
    
    /// 오토레이아웃 제약사항 설정
    private func makeConstraints() {
        // 왼쪽 스택뷰 제약사항
        leftStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Layout.topPadding)
            $0.leading.equalToSuperview().offset(Layout.leftPadding)
            $0.bottom.equalToSuperview().inset(Layout.bottomPadding)
        }
        
        // 오른쪽 스택뷰 제약사항
        rightStackView.snp.makeConstraints {
            $0.centerY.equalTo(leftStackView)
            $0.trailing.equalToSuperview().inset(Layout.rightPadding)
        }
        
        // 회사 이미지뷰 크기 설정
        companyImageView.snp.makeConstraints {
            $0.size.equalTo(Layout.imageViewSize)
        }
    }
    
    /// 셀의 외형 설정
    private func configureAppearance() {
        backgroundColor = .clear
        contentView.backgroundColor = .Gray700
        contentView.layer.cornerRadius = 8
        selectionStyle = .none
    }
    
    // MARK: - Bind Method
    
    /// 상태를 바인딩하여 UI 업데이트
    public func bind(state: State) {
        self.companyImageView.image = state.image
    }
}
