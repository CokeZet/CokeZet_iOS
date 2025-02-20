//
//  ProductImageHeader.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/20/25.
//

import UIKit
import CokeZet_DesignSystem

final class ProductImageHeader: UICollectionReusableView {
    let cokeImageView: UIImageView = UIImageView().then {
        $0.backgroundColor = ZetColor.Gray900.color
        $0.contentMode = .scaleAspectFit
    }
    
    let badgeView: BadgeDiscountRateView = BadgeDiscountRateView()
    
    struct State {
        let cokeImage: UIImage
        let badgeType: DiscountRateType
    }
    
    // 초기화 및 뷰 설정
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    // Interface Builder로부터 초기화할 경우 (사용하지 않을 경우 fatalError 처리)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 서브뷰를 추가하고 오토레이아웃 제약조건을 설정하는 함수
    private func setupViews() {
        [cokeImageView, badgeView].forEach {
            addSubview($0)
        }
        
        cokeImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 28, left: 0, bottom: 28, right: 0))
        }
        
        badgeView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    public func bind(_ state: State) {
        cokeImageView.image = state.cokeImage
        badgeView.setType(state.badgeType)
    }
}
