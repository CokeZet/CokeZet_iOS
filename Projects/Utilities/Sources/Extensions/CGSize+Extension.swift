//
//  CGSize+Extension.swift
//  CokeZet-Utilities
//
//  Created by 김진우 on 2/24/25.
//

import Foundation

public extension CGSize {
    /// 주어진 boundingSize 내에서 사이즈를 비율에 맞게 축소하여 리턴합니다.
    func scaled(toFit boundingSize: CGSize) -> CGSize {
        let widthRatio = boundingSize.width / self.width
        let heightRatio = boundingSize.height / self.height
        let scale = min(widthRatio, heightRatio, 1.0)
        return CGSize(width: self.width * scale, height: self.height * scale)
    }
}
