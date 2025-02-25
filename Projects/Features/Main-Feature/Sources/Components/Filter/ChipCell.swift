//
//  ChipCell.swift
//  Main-Feature
//
//  Created by Daye on 2/25/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class ChipCell: UICollectionViewCell {

    private let chipView = FilterView()

    override var isSelected: Bool {
        willSet {
            let state: FilterState = newValue ? .selected : .deselected
            self.chipView.setState(state)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func makeConstraints() {
        self.contentView.addSubview(chipView)

        self.chipView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setText(_ text: String) {
        self.chipView.setText(text)
    }

    func setState(_ state: FilterState) {
        self.chipView.setState(state)
    }
}
