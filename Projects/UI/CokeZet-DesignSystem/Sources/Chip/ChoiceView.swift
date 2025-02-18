//
//  ChoiceView.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 2/12/25.
//

import UIKit

import SnapKit

public enum ChoiceState {
    case normal // default
    case active

    var coverColor: UIColor? {
        switch self {
        case .normal:
            return UIColor.clear

        case .active:
            return UIColor.Red900.withAlphaComponent(0.6)

        }
    }

    var borderColor: CGColor? {
        switch self {
        case .normal:
            return UIColor.clear.cgColor

        case .active:
            return UIColor.Red600.cgColor

        }
    }

    var borderWidth: CGFloat {
        switch self {
        case .normal:
            return .zero

        case .active:
            return 2
        }
    }
}

public final class ChoiceView: UIView {

    private enum Metric {
        static let size: CGFloat = 66
        static let cornerRadius: CGFloat = size / 2
        static let borderWidth: CGFloat = 1
    }

    private let imageView = UIImageView()
    private let label = ZetLabel(typography: .semiBold(.T16), textColor: .Red500)
    private let coverView = UIView()

    public init(state: ChoiceState = .normal) {
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
        self.setState(state)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.imageView.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.layer.cornerRadius = Metric.cornerRadius
        self.coverView.layer.cornerRadius = Metric.cornerRadius

        self.label.text = "ALL"
        self.label.textAlignment = .center
        self.label.layer.cornerRadius = Metric.cornerRadius
        self.label.backgroundColor = .Gray700
        self.label.layer.borderColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1).cgColor
        self.label.layer.borderWidth = Metric.borderWidth
        self.label.isHidden = true
    }

    private func makeConstraints() {
        self.addSubview(imageView)
        self.addSubview(coverView)
        self.addSubview(label)

        self.snp.makeConstraints {
            $0.size.equalTo(Metric.size)
        }

        self.imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.coverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    public func setState(_ state: ChoiceState) {
        self.coverView.layer.borderColor = state.borderColor
        self.coverView.layer.borderWidth = state.borderWidth
        self.coverView.backgroundColor = state.coverColor
        self.label.textColor = state == .normal ? .Red500 : .White
        self.label.backgroundColor = state == .normal ? .Gray700 : .clear
    }

    public func setImage(_ image: UIImage?) {
        self.imageView.image = image
        self.label.isHidden = image != nil
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let view = ChoiceView()

    view.setImage(CokeZetDesignSystemAsset.icCurly.image)

    return view
}

@available(iOS 17.0, *)
#Preview(
    "active",
    traits: .sizeThatFitsLayout
) {
    let view = ChoiceView()

    view.setImage(CokeZetDesignSystemAsset.icCurly.image)
    view.setState(.active)

    return view
}
