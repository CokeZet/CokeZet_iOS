//
//  AccordianItemView.swift
//  Main-Feature
//
//  Created by Daye on 2/25/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class AccordianItemView: UIView {
    private enum Metric {
        static let spacing: CGFloat = 16
        static let width: CGFloat = 49
    }

    struct State {
        let title: String
        let list: [FilterListView.State]
    }

    private let stackView = UIStackView()
    private let titleLabel = ZetLabel(typography: .semiBold(.T14), textColor: .Gray500)
    private let fileterListView = FilterListView()

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
    }

    private func makeConstraints() {
        self.addSubview(stackView)

        self.stackView.addArrangedSubview(titleLabel)
        self.stackView.addArrangedSubview(fileterListView)

        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.titleLabel.snp.makeConstraints {
            $0.width.equalTo(Metric.width)
        }
    }

    func bind(state: State) {
        self.titleLabel.text = state.title
        self.fileterListView.bind(state: state.list)
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal_초기선택 O",
    traits: .sizeThatFitsLayout
) {
    let view = AccordianItemView()
    view.backgroundColor = .Gray800

    view.bind(
        state: AccordianItemView.State(
            title: "쇼핑몰",
            list: [
                FilterListView.State(title: "쿠팡", isSelected: true),
                FilterListView.State(title: "G마켓", isSelected: false),
                FilterListView.State(title: "11번가", isSelected: false),
                FilterListView.State(title: "네이버", isSelected: false),
                FilterListView.State(title: "마켓컬리", isSelected: false),
                FilterListView.State(title: "마켓컬리", isSelected: false)
            ]
        )
    )

    return view
}
