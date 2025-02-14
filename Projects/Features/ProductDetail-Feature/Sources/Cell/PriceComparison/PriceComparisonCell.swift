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
    
    private lazy var tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = 88
        $0.backgroundColor = .clear
        $0.register(PriceComparisonTableViewCell.self, forCellReuseIdentifier: "PriceComparisonTableViewCell")
    }
    
    // MARK: - Constants
    private enum Layout {
        static let boxTopPadding: CGFloat = 28
        static let boxLeftPadding: CGFloat = 20
        static let boxBottomPadding: CGFloat = 24
        static let boxRightPadding: CGFloat = 20
    }
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        addConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    private func setupLayout() {
        [paddingView].forEach {
            addSubview($0)
        }
        
        [topStack, tableView].forEach {
            paddingView.addSubview($0)
        }
        
        [titleStack, moreButton].forEach {
            topStack.addArrangedSubview($0)
        }
        
        [titleLabel, bubbleButton].forEach {
            titleStack.addArrangedSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(topStack.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        paddingView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(
                UIEdgeInsets(top: Layout.boxTopPadding,
                             left: Layout.boxLeftPadding,
                             bottom: Layout.boxBottomPadding,
                             right: Layout.boxRightPadding)
            )
        }
        
        topStack.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
        }
    }
    
    private func addConfigure() {
        clipsToBounds = false
    }
    
    let imageList = [
        CokeZetDesignSystemAsset.icGmarket.image,
        CokeZetDesignSystemAsset.icCoupang.image,
        CokeZetDesignSystemAsset.ic11st.image,
        CokeZetDesignSystemAsset.icNaver.image,
        CokeZetDesignSystemAsset.icCurly.image,
    ]
}

extension PriceComparisonCell: UITableViewDelegate, UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PriceComparisonTableViewCell") as? PriceComparisonTableViewCell else { return UITableViewCell() }
        cell.bind(state: PriceComparisonTableViewCell.State(image: imageList[indexPath.row]))
        return cell
    }
}
