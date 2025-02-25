//
//  AccordionHeaderView.swift
//  Main-Feature
//
//  Created by Daye on 2/25/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class AccordionHeaderView: UIView {

    private enum Metric {
        static let spacing: CGFloat = 66
        static let toggleSize: CGFloat = 20
    }

    private let stackView = UIStackView()
    private let titleLabel = ZetLabel(typography: .semiBold(.T18), textColor: .White)
    private let toggleButton = UIButton()

    private var isExpanded: Bool = true {
        didSet {
            self.toggleButton.isSelected = !self.isExpanded
        }
    }

    var selectExpanded: ((Bool) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.stackView.axis = .horizontal
        self.stackView.spacing = Metric.spacing

        self.toggleButton.setImage(
            CokeZetDesignSystemAsset.chevronUp.image,
            for: .normal
        )

        self.toggleButton.setImage(
            CokeZetDesignSystemAsset.chevronDown.image,
            for: .selected
        )

        let action = UIAction(handler: { [weak self] _ in
            guard let self else { return }
            self.foldAction()
        })
        self.toggleButton.addAction(action, for: .touchUpInside)
    }

    private func makeConstraints() {
        self.addSubview(stackView)

        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(UIView())
        self.stackView.addArrangedSubview(toggleButton)

        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.toggleButton.snp.makeConstraints {
            $0.size.equalTo(Metric.toggleSize)
        }
    }

    private func foldAction() {
        self.isExpanded.toggle()
        self.selectExpanded?(self.isExpanded)
    }

    func bind(title: String) {
        self.titleLabel.text = title
    }

    func setExpanded(_ isExpanded: Bool) {
        self.isExpanded = isExpanded
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let view = AccordionHeaderView()
    view.backgroundColor = .Gray800

    view.bind(title: "최저가 탐색 조건 설정")

    return view
}
