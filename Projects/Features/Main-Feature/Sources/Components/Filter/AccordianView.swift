//
//  AccordianView.swift
//  Main-Feature
//
//  Created by Daye on 2/25/25.
//

import UIKit

import SnapKit

final class AccordianView: UIView {

    typealias State = AccordianItemView.State

    private enum Metric {
        static let spacing: CGFloat = 14
    }

    private let stackView = UIStackView()
    private let headerView = AccordianHeaderView()
    private let contentView = AccordianContentView()

    private var isExpanded: Bool = true
    var selectFolded: ((Bool) -> Void)?

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
        self.stackView.axis = .vertical
        self.stackView.spacing = Metric.spacing

        self.headerView.selectExpanded = { [weak self] isExpanded in
            self?.isExpanded = isExpanded
            self?.contentView.isHidden = !isExpanded
            self?.selectFolded?(isExpanded)
        }
    }

    private func makeConstraints() {
        self.addSubview(stackView)

        self.stackView.addArrangedSubview(headerView)
        self.stackView.addArrangedSubview(contentView)

        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(list: [State]) {
        self.headerView.bind(title: "최저가 탐색 조건 설정")
        self.contentView.bind(list: list)
    }

    func openAccordian() {
        guard !self.isExpanded else { return }

        self.isExpanded = true
        self.headerView.setExpanded(self.isExpanded)
        self.contentView.isHidden = !self.isExpanded

        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

    func closeAccordian() {
        guard self.isExpanded else { return }

        self.isExpanded = false
        self.headerView.setExpanded(self.isExpanded)
        self.contentView.isHidden = !self.isExpanded

        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let view = AccordianView()
    view.backgroundColor = .Gray800

    view.bind(
        list: Array(
            repeating: AccordianItemView.State(
                title: "쇼핑몰",
                list: [
                    FilterListView.State(title: "쿠팡", isSelected: true),
                    FilterListView.State(title: "G마켓", isSelected: false),
                    FilterListView.State(title: "11번가", isSelected: false),
                    FilterListView.State(title: "네이버", isSelected: false),
                    FilterListView.State(title: "마켓컬리", isSelected: false),
                    FilterListView.State(title: "마켓컬리", isSelected: false)
                ]
            ),
            count: 5
        )

    )

    return view
}
