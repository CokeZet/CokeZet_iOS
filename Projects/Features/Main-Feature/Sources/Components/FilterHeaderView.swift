//
//  FilterHeaderView.swift
//  Main-Feature
//
//  Created by Daye on 2/27/25.
//

import UIKit

import SnapKit

final class ProductFilterHeaderView: UICollectionReusableView {

    typealias State = AccordionView.State

    private let headerView = AccordionView()
    
    var selectFolded: ((Bool) -> Void)? {
        didSet {
            self.headerView.selectFolded = selectFolded
        }
    }

    var selectItem: ((IndexPath) -> Void)? {
        didSet {
            self.headerView.selectItem = self.selectItem
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeConstraints() {
        self.addSubview(self.headerView)

        self.headerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        }
    }
    
    func isGuestSetup(isGuest: Bool) {
        headerView.isGuestSetup(isGuest: isGuest)
    }

    func bind(list: [State]) {
        self.headerView.bind(list: list)
    }
}
