//
//  UIImage+Extension.swift
//  CokeZet-Utilities
//
//  Created by 김진우 on 3/21/25.
//

import UIKit

public extension UIImage {
    func resize(targetSize: CGSize) -> UIImage? {
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        let ratio = min(widthRatio, heightRatio)
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let newRect = CGRect(origin: .zero, size: newSize)
        
        // 투명 배경 설정
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        
        // 이미지 렌더링 모드 설정 (선택 사항)
        draw(in: newRect, blendMode: .normal, alpha: 1.0)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
