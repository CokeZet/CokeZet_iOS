//
//  BadgeDiscountRateView.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 2/14/25.
//

import UIKit

import SnapKit

public final class BadgeDiscountRateView: UIView {

    private enum Metric {
        static let width: CGFloat = 64
        static let height: CGFloat = 24
        static let cornerRadius: CGFloat = 4
        static let borderWidth: CGFloat = 1
    }

    private let label = ZetLabel(typography: .semiBold(.T12))
    private var borderGradient: CAGradientLayer?
    private var backgroundGradient: CAGradientLayer?

    public init() {
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundGradient?.frame = self.bounds

        guard let borderGradient else { return }
        borderGradient.frame = self.bounds

        guard let shape = borderGradient.mask as? CAShapeLayer else { return }
        shape.path = UIBezierPath(
            roundedRect: self.bounds,
            cornerRadius: Metric.cornerRadius
        ).cgPath
    }

    private func addConfigure() {
        self.label.textAlignment = .center
        self.layer.cornerRadius = Metric.cornerRadius
        self.clipsToBounds = true
    }

    private func makeConstraints() {
        self.addSubview(label)
        self.label.snp.makeConstraints {
            $0.height.equalTo(Metric.height)
            $0.width.equalTo(Metric.width)
            $0.edges.equalToSuperview()
        }
    }

    public func setType(_ type: DiscountRateType) {
        self.label.text = type.text
        self.label.textColor = type.textColor
        self.label.font = type.font
        self.backgroundColor = type.backgroundColor

        if type == .zetPick {
            self.setGradient()
        }
    }

    private func setGradient() {
        self.borderGradient?.removeFromSuperlayer()
        self.backgroundGradient?.removeFromSuperlayer()

        let backgroundGradient = CAGradientLayer()
        backgroundGradient.colors = [
            UIColor(red: 243/255, green: 78/255, blue: 75/255, alpha: 1).cgColor,
            UIColor(red: 101/255, green: 115/255, blue: 243/255, alpha: 1).cgColor,
        ]
        backgroundGradient.cornerRadius = Metric.cornerRadius
        backgroundGradient.startPoint = CGPoint(x: 0, y: 0.5)
        backgroundGradient.endPoint   = CGPoint(x: 1, y: 0.5)
        self.backgroundGradient = backgroundGradient

        let borderGradient = CAGradientLayer()
        borderGradient.colors = [
            UIColor(red: 213/255, green: 29/255, blue: 26/255, alpha: 1).cgColor,
            UIColor(red: 48/255, green: 66/255, blue: 227/255, alpha: 1).cgColor,
        ]
        borderGradient.cornerRadius = Metric.cornerRadius
        borderGradient.startPoint = CGPoint(x: 0, y: 0.5)
        borderGradient.endPoint   = CGPoint(x: 1, y: 0.5)

        self.borderGradient = borderGradient

        let shape = CAShapeLayer()
        shape.lineWidth = Metric.borderWidth
        shape.path = UIBezierPath(rect: self.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.cornerRadius = Metric.cornerRadius
        borderGradient.mask = shape

        self.layer.addSublayer(backgroundGradient)
        self.layer.addSublayer(borderGradient)


        self.bringSubviewToFront(label)
    }
}

@available(iOS 17.0, *)
#Preview(
    "제트픽",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    let view = BadgeDiscountRateView()

    view.setType(.zetPick)

    contentView.addSubview(view)

    view.snp.makeConstraints {
        $0.center.equalToSuperview()
    }

    contentView.backgroundColor = .Gray800

    return contentView
}

@available(iOS 17.0, *)
#Preview(
    "대박",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    let view = BadgeDiscountRateView()

    view.setType(.large)

    contentView.addSubview(view)

    view.snp.makeConstraints {
        $0.center.equalToSuperview()
    }

    contentView.backgroundColor = .Gray800

    return contentView
}
