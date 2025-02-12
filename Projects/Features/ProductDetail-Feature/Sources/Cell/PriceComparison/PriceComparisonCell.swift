//
//  PriceComparisonCell.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/6/25.
//

import UIKit

import CokeZet_DesignSystem
import CokeZet_Components

public final class PriceComparisonCell: UICollectionViewCell {
    private let paddingView: UIView = UIView(frame: .zero).then {
        $0.isUserInteractionEnabled = true
    }
    
    private let topStack: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    private let titleStack: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let titleLabel: ZetLabel = ZetLabel(typography: .T18, textColor: .White).then {
        $0.text = "가격비교"
    }
    
    private let bubbleButton: BubblePopupButton = BubblePopupButton("내가 설정한 쇼핑몰 외의 사이트 최저가도 함께 갖고 왔어요.\n카드 혜택의 경우 조건이 있을 수 있어요.")
    
    private let moreButton: BubblePopupButton = BubblePopupButton("내가 설정한 쇼핑몰 외의 사이트 최저가도 함께 갖고 왔어요.\n카드 혜택의 경우 조건이 있을 수 있어요.")
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        [paddingView].forEach {
            addSubview($0)
        }
        
        [topStack].forEach {
            paddingView.addSubview($0)
        }
        
        [titleStack, moreButton].forEach {
            topStack.addArrangedSubview($0)
        }
        
        [titleLabel, bubbleButton].forEach {
            titleStack.addArrangedSubview($0)
        }
        
        paddingView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 28, left: 20, bottom: 24, right: 20))
        }
        
        topStack.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
}
