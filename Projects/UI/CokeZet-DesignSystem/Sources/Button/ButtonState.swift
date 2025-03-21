//
//  ButtonState.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/23/25.
//

import UIKit

public enum ButtonState: CaseIterable {
    case normal
    case pressed
    case disabled

    func titleColor(_ color: Color) -> UIColor {
        switch color {
        case .red, .gray:
            guard self == .disabled else { return .White }
            return .Gray500

        case .white:
            guard self == .disabled else { return .black }
            return .Gray500
        }
    }

    func backgroundColor(_ color: Color) -> UIColor {
        switch color {
        case .red:
            switch self {
            case .pressed:
                return .Red700
            case .normal:
                return .Red600
            case .disabled:
                return .Gray700
            }

        case .white:
            switch self {
            case .pressed:
                return .Red200
            case .normal:
                return .Red50
            case .disabled:
                return .Gray700
            }
            
        case .gray:
            switch self {
            case .pressed:
                return .Gray600
            case .normal:
                return .Gray500
            case .disabled:
                return .Gray700
            }
        }
    }

    public enum Color {
        case red
        case white
        case gray
    }
}
