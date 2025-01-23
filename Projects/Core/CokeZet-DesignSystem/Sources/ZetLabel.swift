//
//  ZetLabel.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/22/25.
//

import UIKit

import CokeZet_Utilities

public class ZetLabel: UILabel {

    private let typography: Typography

    private let letterSpacing: CGFloat = -2

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

    public var hasStrikeThrough: Bool {
        didSet {
            configureTypography()
        }
    }

    public var hasUnderline: Bool {
        didSet {
            configureTypography()
        }
    }

    public init(typography: Typography, frame: CGRect) {
        self.typography = typography
        super.init(frame: frame)
        configureTypography()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTypography() {
        self.setAttributed(
            text: self.text,
            font: self.typography.font,
            color: self.textColor,
            letterSpacing: self.letterSpacing,
            lineHeight: nil, // 추후 설정
            textAlignment: self.textAlignment,
            lineBreakMode: self.lineBreakMode,
            hasStrikeThrough: self.hasStrikeThrough,
            hasUnderline: self.hasUnderline
        )
    }
}
