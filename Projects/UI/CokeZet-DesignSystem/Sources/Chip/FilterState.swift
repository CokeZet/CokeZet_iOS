//
//  FilterState.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 2/15/25.
//

import UIKit

public enum FilterState {
    case deselected
    case selected
    case disabled

    var borderColor: CGColor {
        switch self {
        case .deselected:
            return UIColor.Gray700.cgColor
        case .selected:
            return UIColor.Purple600.withAlphaComponent(0.5).cgColor
        case .disabled:
            return UIColor(red: 41/255, green: 41/255, blue: 41/255, alpha: 1).cgColor
        }
    }

    var textColor: UIColor {
        switch self {
        case .deselected:
            return .Gray400
        case .selected:
            return .Purple600
        case .disabled:
            return UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1)
        }
    }

    var backgroundColor: UIColor {
        switch self {
        case .deselected:
            return UIColor.clear
        case .selected:
            return .Purple600.withAlphaComponent(0.1)
        case .disabled:
            return UIColor(red: 39/255, green: 39/255, blue: 39/255, alpha: 0.18)
        }
    }
}
