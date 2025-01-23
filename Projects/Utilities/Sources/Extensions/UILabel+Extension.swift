//
//  UILabel+Extension.swift
//  CokeZet-Utilities
//
//  Created by Daye on 1/22/25.
//

import UIKit

extension UILabel {
    public func setAttributed(
        text: String?,
        font: UIFont,
        color: UIColor?,
        letterSpacing: CGFloat,
        lineHeight: CGFloat?,
        textAlignment: NSTextAlignment?,
        lineBreakMode: NSLineBreakMode?,
        hasStrikeThrough: Bool,
        hasUnderline: Bool
    ) {
        self.attributedText = self.attribute(
            text: text ?? "",
            font: font,
            color: color,
            letterSpacing: letterSpacing,
            textAlignment: textAlignment,
            lineBreakMode: lineBreakMode,
            hasStrikeThrough: hasStrikeThrough,
            hasUnderline: hasUnderline
        )
    }

    private func attribute(
        text: String,
        font: UIFont,
        color: UIColor? = nil,
        letterSpacing: CGFloat,
        textAlignment: NSTextAlignment? = nil,
        lineBreakMode: NSLineBreakMode? = nil,
        hasStrikeThrough: Bool = false,
        hasUnderline: Bool = false
    ) -> NSMutableAttributedString {

        let attributed = NSMutableAttributedString(string: text)

        let style = NSMutableParagraphStyle()

        attributed.addAttribute(
            .font,
            value: font,
            range: NSRange(location: 0, length: attributed.length)
        )

        if let color {
            attributed.addAttribute(
                .foregroundColor,
                value: color,
                range: NSRange(location: 0, length: attributed.length)
            )
        }

        attributed.addAttribute(
            .kern,
            value: letterSpacing,
            range: NSRange(location: 0, length: attributed.length)
        )

        if let textAlignment {
            style.alignment = textAlignment
        }

        if let lineBreakMode {
            style.lineBreakMode = lineBreakMode
        }

        attributed.addAttribute(
            .paragraphStyle,
            value: style,
            range: NSRange(location: 0, length: attributed.length)
        )

        if hasStrikeThrough {
            attributed.addAttribute(
                NSAttributedString.Key.strikethroughStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: attributed.length)
            )
        }

        if hasUnderline {
            attributed.addAttribute(
                NSAttributedString.Key.underlineStyle,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: attributed.length)
            )
        }

        return attributed
    }
}
