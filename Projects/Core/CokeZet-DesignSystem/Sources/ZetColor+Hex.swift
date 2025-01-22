//
//  ZetColor+Hex.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/22/25.
//

import Foundation

extension ZetColor {

    var hex: String {
        switch self {

        case .Primary:
            ZetColor.Red700.hex
        case .Sub:
            ZetColor.Purple700.hex
        case .Gray:
            ZetColor.Gray900.hex

        case .Red:
            "#C4100E"
        case .Red900:
            "#CD110E"
        case .Red800:
            "#DF1A17"
        case .Red700:
            "#E91613"
        case .Red600:
            "#EE2D2B"
        case .Red500:
            "#F34E4B"
        case .Red400:
            "#F4706E"
        case .Red300:
            "#FF9D9C"
        case .Red200:
            "#FFBBBA"
        case .Red100:
            "#FFDEDE"
        case .Red50:
            "#FFF1F1"

        case .Purple:
            "#2C39B1"
        case .Purple900:
            "#3948D2"
        case .Purple800:
            "#4859F4"
        case .Purple700:
            "#6573F3"
        case .Purple600:
            "#7B87F0"
        case .Purple500:
            "#8C96F1"
        case .Purple400:
            "#A2AAEF"
        case .Purple300:
            "#B4BAF0"
        case .Purple200:
            "#CDD1F5"
        case .Purple100:
            "#E8EAFA"
        case .Purple50:
            "#F5F6FF"

        case .Black:
            "#0E0D0D"
        case .Gray900:
            "#121212"
        case .Gray800:
            "#2B2727"
        case .Gray700:
            "#494848"
        case .Gray600:
            "#6B6666"
        case .Gray500:
            "#989797"
        case .Gray400:
            "#B7B6B6"
        case .Gray300:
            "#D3D2D2"
        case .Gray200:
            "#E4E3E3"
        case .Gray100:
            "#F0ECEC"
        case .White:
            "#FFFFFF"
        }
    }
}
