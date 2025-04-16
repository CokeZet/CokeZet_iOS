//
//  ProductInfomationCell.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/14/25.
//

import UIKit
import CokeZet_DesignSystem

public final class ProductInfomationCell: UICollectionViewCell {
    
    public struct State {
        var foodType: String
        var packType: String
        var capacity: String
        var quantity: String
        var features: [String]
    }
    
    enum Cell: Int, CaseIterable {
        case foodType
        case packType
        case capacity
        case quantity
        case features
    }
    
    private var state: State?
    
    private let paddingView: UIView = UIView()
    
    private let titleLabel: ZetLabel = ZetLabel(typography: .semiBold(.T18), textColor: .White).then {
        $0.text = "제품정보"
    }
    
    private lazy var tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.registerCell(type: PriceInfomationTableViewCell.self)
        $0.backgroundColor = .clear
        $0.rowHeight = 38
    }
    
    private let subLabel: ZetLabel = ZetLabel(typography: .medium(.T12), textColor: .Gray500).then {
        $0.text = "※자세한 내용은 해당 제품의 판매 사이트에서 확인해주세요."
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        makeConstraints()
        addConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(paddingView)
        
        [titleLabel, tableView, subLabel].forEach {
            paddingView.addSubview($0)
        }
    }
    
    private func makeConstraints() {
        paddingView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 28, left: 20, bottom: 24, right: 20))
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
        
        subLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(tableView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func addConfigure() {
        
    }
    
    public func bind(_ state: State) {
        self.state = state
    }
}

extension ProductInfomationCell: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: PriceInfomationTableViewCell.self, for: indexPath)
        if indexPath.row == 0 {
            cell.borderSetup(.both)
        } else {
            cell.borderSetup(.bottom)
        }
        
        if let state {
            switch Cell(rawValue: indexPath.row) {
            case .foodType:
                cell.bind(.init(typeText: "식품 유형", describeText: state.foodType))
            case .packType:
                cell.bind(.init(typeText: "포장 형태", describeText: state.packType))
            case .capacity:
                cell.bind(.init(typeText: "용량", describeText: state.capacity))
            case .quantity:
                cell.bind(.init(typeText: "개수", describeText: state.quantity))
            case .features:
                cell.bind(.init(typeText: "특징", describeText: state.features.joined(separator: ", ")))
            default:
                break
            }
        }
        return cell
    }
    
    
}
