//
//  Typography.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/22/25.
//

import Foundation

public enum Typography: Hashable {
    case extraBold(TypeScale)
    case bold(TypeScale)
    case semiBold(TypeScale)
    case medium(TypeScale)
}

public enum TypeScale: Hashable {
    case T24
    case T22
    case T20
    case T18
    case T16
    case T14
    case T12

    var size: CGFloat {
        switch self {
        case .T24:
            return 24
        case .T22:
            return 22
        case .T20:
            return 20
        case .T18:
            return 18
        case .T16:
            return 16
        case .T14:
            return 14
        case .T12:
            return 12
        }
    }
}
