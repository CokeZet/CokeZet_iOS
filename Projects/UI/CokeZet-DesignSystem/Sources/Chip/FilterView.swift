//
//  FilterView.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 2/14/25.
//

import UIKit

import SnapKit

public final class FilterView: UIView {

    private enum Metric {
        static let horizontalInset: CGFloat = 10
        static let verticalInset: CGFloat = 6
        static let cornerRadius: CGFloat = 13
        static let borderWidth: CGFloat = 1
    }

    private let label = UILabel()

    public init(state: ChoiceState = .normal) {
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
        self.setState(.deselected)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.layer.borderWidth = Metric.borderWidth
        self.layer.cornerRadius = Metric.cornerRadius

        self.label.textAlignment = .center
        self.label.font = Typography.semiBold(.T14).font
    }

    private func makeConstraints() {
        self.addSubview(label)

        self.label.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(Metric.horizontalInset)
            $0.verticalEdges.equalToSuperview().inset(Metric.verticalInset)
            $0.centerY.equalToSuperview()
        }
    }

    public func setState(_ state: FilterState) {
        self.layer.borderColor = state.borderColor
        self.backgroundColor = state.backgroundColor
        self.label.textColor = state.textColor
    }

    public func setText(_ text: String) {
        self.label.text = text
    }
}

@available(iOS 17.0, *)
#Preview(
    "deselected",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    let view = FilterView()
    contentView.backgroundColor = .Gray800
    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.center.equalToSuperview()
    }
    view.setText("190ml~210ml")

    return contentView
}

@available(iOS 17.0, *)
#Preview(
    "selected",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    let view = FilterView()
    contentView.backgroundColor = .Gray800
    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.center.equalToSuperview()
    }
    view.setText("190ml~210ml")
    view.setState(.selected)

    return contentView
}
