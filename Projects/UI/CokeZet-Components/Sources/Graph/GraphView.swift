//
//  GraphView.swift
//  CokeZet-Components
//
//  Created by 김진우 on 2/5/25.
//

import UIKit
import CokeZet_DesignSystem

import SnapKit

public final class GraphView: UICollectionViewCell {

    private let titleLabel: ZetLabel = ZetLabel(typography: .semiBold(.T18), textColor: .White).then {
        $0.text = "최저가 그래프"
    }
    
    private let subscribeStackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 4
    }
    
    private let subscribeLabel: ZetLabel = ZetLabel(typography: .medium(.T12), textColor: .White).then {
        $0.text = "현재 100ml당 193원"
    }
    
    private let graphListView: GraphListView = GraphListView(frame: .zero)
    
    private let subscribeButton: BubblePopupButton = BubblePopupButton("내가 설정한 쇼핑몰 외의 사이트 최저가도 함께 갖고 왔어요.\n 카드 혜택의 경우 조건이 있을 수 있어요.")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [titleLabel, subscribeStackView, graphListView].forEach {
            addSubview($0)
        }
        
        [subscribeLabel, subscribeButton].forEach {
            subscribeStackView.addArrangedSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        subscribeStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(titleLabel)
        }
        
        graphListView.snp.makeConstraints {
            $0.top.equalTo(titleLabel).offset(32)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-24)
        }
    }
    
    public func bind(_ type: DiscountRateType) {
        graphListView.selectedIndex = type
    }
}

@available(iOS 17.0, *)
#Preview(
    "button state",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    contentView.alignment = .fill
    contentView.spacing = 10
    contentView.backgroundColor = ZetColor.Gray800.color
    
    let tool = GraphView()
    tool.snp.makeConstraints {
        $0.width.equalTo(360)
    }
    contentView.addArrangedSubview(tool)

    return tool
}
