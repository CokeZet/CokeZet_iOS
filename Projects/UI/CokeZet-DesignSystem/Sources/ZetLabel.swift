//
//  ZetLabel.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/22/25.
//

import UIKit

import CokeZet_Utilities

open class ZetLabel: UILabel {

    private let typography: Typography

    public override var text: String? {
        didSet {
            configureTypography()
        }
    }

    public override var textColor: UIColor? {
        didSet {
            configureTypography()
        }
    }

    public override var textAlignment: NSTextAlignment {
        didSet {
            configureTypography()
        }
    }

    public override var lineBreakMode: NSLineBreakMode {
        didSet {
            configureTypography()
        }
    }

    public var hasStrikeThrough: Bool = false {
        didSet {
            configureTypography()
        }
    }

    public var hasUnderline: Bool = false {
        didSet {
            configureTypography()
        }
    }

    public init(
        typography: Typography,
        textColor: UIColor = .Basic222222
    ) {
        self.typography = typography
        super.init(frame: .zero)
        self.textColor = textColor
        configureTypography()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTypography() {
        self.setAttributed(
            text: self.text,
            font: self.typography.font,
            color: self.textColor,
            letterSpacing: .zero, // 추후 설정
            lineHeight: nil, // 추후 설정
            textAlignment: self.textAlignment,
            lineBreakMode: self.lineBreakMode,
            hasStrikeThrough: self.hasStrikeThrough,
            hasUnderline: self.hasUnderline
        )
    }
}

@available(iOS 17.0, *)
#Preview(
    "sigle line",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    let labelT24 = ZetLabel(
        typography: .extraBold(.T24),
        textColor: .Basic222222
    )
    labelT24.text = "ZET와 함께 제로콜라 최저가 탐색"

    let labelT22 = ZetLabel(
        typography: .bold(.T22),
        textColor: .Primary296DEA
    )
    labelT22.text = "ZET와 함께 제로콜라 최저가 탐색"

    let labelT20 = ZetLabel(
        typography: .semiBold(.T20),
        textColor: .AdditionalDE0000
    )
    labelT20.text = "ZET와 함께 제로콜라 최저가 탐색"

    contentView.addArrangedSubview(labelT24)
    contentView.addArrangedSubview(labelT22)
    contentView.addArrangedSubview(labelT20)

    return contentView
}

@available(iOS 17.0, *)
#Preview(
    "multi line",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    let labelT24 = ZetLabel(
        typography: .medium(.T24),
        textColor: .Basic666666
    )
    labelT24.numberOfLines = 2
    labelT24.text = "ZET와 함께 제로콜라\n최저가 탐색 시작해요"

    contentView.addArrangedSubview(labelT24)

    return contentView
}

