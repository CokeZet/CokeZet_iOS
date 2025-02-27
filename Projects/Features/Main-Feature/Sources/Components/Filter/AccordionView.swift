//
//  AccordionView.swift
//  Main-Feature
//
//  Created by Daye on 2/25/25.
//

import UIKit

import SnapKit

final class AccordionView: UIView {

    typealias State = AccordionItemView.State

    private enum Metric {
        static let spacing: CGFloat = 24
        static let top: CGFloat = 24
        static let bottom: CGFloat = 20
    }

    private let stackView = UIStackView()
    private let headerView = AccordionHeaderView()
    private let contentView = AccordionContentView()

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
            $0.top.equalToSuperview().offset(Metric.top)
            $0.bottom.equalToSuperview().offset(-Metric.bottom)
            $0.horizontalEdges.equalToSuperview()
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
    let view = AccordionView()
    view.backgroundColor = .Gray800

    view.bind(
        list: Array(
            repeating: AccordionItemView.State(
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
