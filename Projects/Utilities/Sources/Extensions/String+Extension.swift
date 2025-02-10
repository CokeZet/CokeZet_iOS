//
//  String+Extension.swift
//  CokeZet-Utilities
//
//  Created by 김진우 on 2/3/25.
//

import Foundation
import UIKit

public extension String {
    // 숫자에 콤마를 추가하는 함수
    func formatWithComma() -> String {
        if let number = Int(self) {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter.string(from: NSNumber(value: number)) ?? self
        }
        return self
    }
}
