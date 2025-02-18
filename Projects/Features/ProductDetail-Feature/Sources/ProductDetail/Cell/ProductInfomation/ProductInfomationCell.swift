//
//  ProductInfomationCell.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/14/25.
//

import UIKit
import CokeZet_DesignSystem

public final class ProductInfomationCell: UICollectionViewCell {
    
    private let paddingView: UIView = UIView()
    
    private let titleLabel: ZetLabel = ZetLabel(typography: .semiBold(.T18), textColor: .White).then {
        $0.text = "제품정보"
    }
    
    private lazy var tableView: UITableView = UITableView(frame: .zero, style: .plain).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(PriceInfomationTableViewCell.self, forCellReuseIdentifier: "PriceInfomationTableViewCell")
        $0.backgroundColor = .clear
        $0.rowHeight = 38
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
        
        [titleLabel, tableView].forEach {
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
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
        }
    }
    
    private func addConfigure() {
        
    }
}

extension ProductInfomationCell: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PriceInfomationTableViewCell") as? PriceInfomationTableViewCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            cell.borderSetup(.both)
        } else {
            cell.borderSetup(.bottom)
        }
        return cell
    }
    
    
}
