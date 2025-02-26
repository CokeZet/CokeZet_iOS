//
//  BannerIndicatorView.swift
//  Main-Feature
//
//  Created by Daye on 2/26/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class BannerIndicatorView: UIView {

    private enum Metric {
        static let cornerRadius: CGFloat = 10
        static let height: CGFloat = 20
        static let spacing: CGFloat = 1
        static let horizontalInset: CGFloat = 10
    }

    private let currentLabel = ZetLabel(typography: .extraBold(.T12), textColor: .White)
    private let totalLabel = ZetLabel(typography: .medium(.T12), textColor: .White)

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
        self.addBlurEffect(to: self)
        self.clipsToBounds = true
        self.layer.cornerRadius = Metric.cornerRadius
    }

    private func makeConstraints() {
        self.addSubview(currentLabel)
        self.addSubview(totalLabel)

        self.snp.makeConstraints {
            $0.height.equalTo(Metric.height)
        }

        self.currentLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(Metric.horizontalInset)
        }

        self.totalLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(currentLabel.snp.trailing).offset(Metric.spacing)
            $0.trailing.equalToSuperview().offset(-Metric.horizontalInset)
        }
    }

    private func addBlurEffect(to view: UIView) {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)

        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        view.addSubview(blurView)
    }

    func setCurrentIndex(_ index: Int) {
        self.currentLabel.text = "\(index) "
    }

    func setTotalIndex(_ index: Int) {
        self.totalLabel.text = "/ \(index)"
    }
}


@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    let view = BannerIndicatorView()

    contentView.backgroundColor = .Gray700
    contentView.addSubview(view)

    view.snp.makeConstraints {
        $0.edges.equalToSuperview()
    }
    view.setTotalIndex(5)
    view.setCurrentIndex(1)

    return contentView
}

