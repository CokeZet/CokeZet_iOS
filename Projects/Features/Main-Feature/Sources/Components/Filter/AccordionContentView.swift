//
//  AccordionContentView.swift
//  Main-Feature
//
//  Created by Daye on 2/25/25.
//

import UIKit

import SnapKit

final class AccordionContentView: UIView {

    typealias State = AccordionItemView.State

    private enum Metric {
        static let spacing: CGFloat = 16
    }

    private let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConfigure()
        self.makeConstraints()
    }

    /// Chips 선택 시 index 방출 closure
    var didSelectItem: ((IndexPath) -> Void)?

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.stackView.axis = .vertical
        self.stackView.spacing = Metric.spacing
    }

    private func makeConstraints() {
        self.addSubview(stackView)

        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func bind(list: [State]) {
        self.stackView.subviews.forEach { $0.removeFromSuperview() }

        for (index, item) in list.enumerated() {
            let view = AccordionItemView()
            view.bind(state: item)

            view.didSelectItem = { [weak self] itemIndex in
                let indexPath = IndexPath(row: itemIndex, section: index)
                self?.didSelectItem?(indexPath)
            }

            self.stackView.addArrangedSubview(view)
        }
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let view = AccordionContentView()
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

    view.didSelectItem = { (indexPath) in
        print(indexPath)
    }

    return view
}
