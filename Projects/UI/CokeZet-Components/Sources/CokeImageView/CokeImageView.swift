//
//  CokeImageView.swift
//  CokeZet-Components
//
//  Created by 김진우 on 2/24/25.
//

import CokeZet_DesignSystem
import UIKit

public final class CokeImageView: UIImageView {
    var leftCokeImage: UIImage
    var rightCokeImage: UIImage
    var leftAngle: CGFloat
    var rightAngle: CGFloat
    
    // left와 right 이미지의 투명도를 지정할 수 있는 프로퍼티 (0.0 ~ 1.0)
    var leftAlpha: CGFloat = 0.5
    var rightAlpha: CGFloat = 1.0
    let cokeType: CokeType
    
    public struct State {
        let leftCokeImage: UIImage
        let rightCokeImage: UIImage
        
        // 투명도 옵션 추가 (기본값 1.0, 완전 불투명)
        let leftCokeAlpha: CGFloat
        let rightCokeAlpha: CGFloat
        
        public init(leftCokeImage: UIImage,
                    rightCokeImage: UIImage) {
            self.leftCokeImage = leftCokeImage
            self.rightCokeImage = rightCokeImage
            self.leftCokeAlpha = 0.5
            self.rightCokeAlpha = 1
        }
    }
    
    public init(_ state: State, _ cokeType: CokeType = .can) {
        self.leftCokeImage = state.leftCokeImage
        self.rightCokeImage = state.rightCokeImage
        self.cokeType = cokeType
        if cokeType == .can {
            self.leftAngle = -11
            self.rightAngle = 24
        } else {
            self.leftAngle = 0
            self.rightAngle = 0
        }
        
        super.init(frame: .zero)
        self.imageSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 이미지 합성 작업 후 UIImageView의 image 프로퍼티에 할당합니다.
    public func imageSetup() {
        let image = combineImages(
            left: leftCokeImage,
            right: rightCokeImage,
            leftRotationDegrees: leftAngle,
            rightRotationDegrees: rightAngle,
            leftAlpha: leftAlpha,
            rightAlpha: rightAlpha
        )
        self.image = image
    }
    
    /// 주어진 이미지를 degree 단위로 회전하는 함수
    /// - Parameters:
    ///   - image: 회전할 UIImage
    ///   - degrees: 회전 각도 (degree 단위)
    ///   - leftFlag: left 이미지의 경우 크기를 약간 축소해서 그리기 위한 flag (default false)
    /// - Returns: 회전된 UIImage (실패 시 nil)
    private func rotateImage(_ image: UIImage, byDegrees degrees: CGFloat, leftFlag: Bool = false) -> UIImage? {
        let radians = degrees * .pi / 180   // degree를 radian으로 변환
        var leftFlag = leftFlag
        // 이미지 회전 후 외곽 사각형 크기를 계산
        let newViewBox = UIView(frame: CGRect(origin: .zero,
                                              size: CGSize(width: image.size.width + 200, height: image.size.height)))
        newViewBox.transform = CGAffineTransform(rotationAngle: radians)
        let rotatedSize = newViewBox.frame.size
        
        // 회전된 이미지를 담을 그래픽 컨텍스트 시작
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // 회전 중심을 컨텍스트의 중앙으로 이동
        context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        context.rotate(by: radians)
        
        var imageScale: CGFloat = 0
        switch cokeType {
        case .can:
            imageScale = 1.3
        case .pet:
            imageScale = 0.7
            leftFlag.toggle()
        }
        // leftFlag가 true인 경우 이미지 크기를 약간 축소하여 그립니다.
        let drawWidth = leftFlag ? image.size.width / imageScale : image.size.width * (cokeType == .can ? 1.2 : 1)
        let drawHeight = leftFlag ? image.size.height / imageScale : image.size.height * (cokeType == .can ? 1.2 : 1)
        
        image.draw(in: CGRect(x: -drawWidth / 2,
                              y: -drawHeight / 2,
                              width: drawWidth,
                              height: drawHeight))
        
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rotatedImage
    }
    
    /// left 이미지와 right 이미지를 회전시킨 후, 캔버스(200 x 200)에 margin을 두어 그리며, 투명도 옵션을 통해 각각의 이미지 알파값을 적용하는 함수입니다.
    /// left 이미지는 뒤쪽(배경)으로, right 이미지는 앞쪽 중앙에 그려집니다.
    /// - Parameters:
    ///   - left: 배경으로 사용할 UIImage
    ///   - right: 앞쪽에 표시할 UIImage
    ///   - leftRotationDegrees: left 이미지 회전 각도 (degree 단위)
    ///   - rightRotationDegrees: right 이미지 회전 각도 (degree 단위)
    ///   - leftAlpha: left 이미지의 투명도 (0.0 ~ 1.0)
    ///   - rightAlpha: right 이미지의 투명도 (0.0 ~ 1.0)
    /// - Returns: 합쳐진 UIImage (실패 시 nil)
    private func combineImages(left: UIImage, right: UIImage, leftRotationDegrees: CGFloat, rightRotationDegrees: CGFloat, leftAlpha: CGFloat, rightAlpha: CGFloat) -> UIImage? {
        // 각각의 이미지를 지정된 각도로 회전 (left 이미지는 약간 축소하여 그리도록 leftFlag 사용)
        guard let rotatedLeft = rotateImage(left, byDegrees: leftRotationDegrees, leftFlag: true) else {
            return nil
        }
        guard let rotatedRight = rotateImage(right, byDegrees: rightRotationDegrees) else {
            return nil
        }
        
        // 캔버스 사이즈를 200 x 200으로 고정 (높은 해상도를 위해 원본 이미지 scale 유지)
        let canvasSize = CGSize(width: 200, height: 200)
        
        let availableSize = CGSize(width: canvasSize.width + 20,
                                   height: canvasSize.height + 20)
        
        // 회전된 이미지들을 availableSize에 맞춰 축소 (비율 유지)
        let scaledLeftSize = rotatedLeft.size.scaled(toFit: availableSize)
        let scaledRightSize = rotatedRight.size.scaled(toFit: availableSize)
        
        // UIGraphicsBeginImageContextWithOptions에서 scale을 0.0 사용하면 디바이스의 화면 scale 적용 (레티나 지원)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0.0)
        var (lx, ly): (CGFloat, CGFloat) = (0, 0)
        var (rx, ry): (CGFloat, CGFloat) = (0, 0)
        
        switch cokeType {
        case .can:
            (lx, ly) = (-40, -30)
            (rx, ry) = (15, 40)
        case .pet:
            (lx, ly) = (-30, 0)
            (rx, ry) = (20, 0)
        }
        
        // left 이미지는 배경이므로 먼저 그리기
        // 투명도 leftAlpha 값을 draw 메서드의 alpha 파라미터로 적용함
        let leftOrigin = CGPoint(x: (canvasSize.width - scaledLeftSize.width) / 2 + lx,
                                 y: (canvasSize.height - scaledLeftSize.height) / 2 + ly)
        rotatedLeft.draw(in: CGRect(origin: leftOrigin, size: scaledLeftSize),
                         blendMode: .normal,
                         alpha: leftAlpha)
        
        // right 이미지는 그 위에 그리기 (투명도 rightAlpha 적용)
        let rightOrigin = CGPoint(x: (canvasSize.width - scaledRightSize.width) / 2 + rx,
                                  y: (canvasSize.height - scaledRightSize.height) / 2 + ry)
        rotatedRight.draw(in: CGRect(origin: rightOrigin, size: scaledRightSize),
                          blendMode: .normal,
                          alpha: rightAlpha)
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return combinedImage
    }
}



@available(iOS 17.0, *)
#Preview(
    "Coke Image",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    contentView.alignment = .fill
    contentView.spacing = 10
    contentView.backgroundColor = ZetColor.Gray200.color
    
    let tool = CokeImageView(.init(leftCokeImage: CokeZetDesignSystemAsset.icPetPepsi500.image,
                                   rightCokeImage: CokeZetDesignSystemAsset.icPetPepsi500.image),
                             .pet)
    
    let tool2 = CokeImageView(.init(leftCokeImage: CokeZetDesignSystemAsset.icCanPepsiZeroCaffeine355.image,
                                   rightCokeImage: CokeZetDesignSystemAsset.icCanPepsiZeroCaffeine355.image),
                             .can)
    
    tool.snp.makeConstraints {
        $0.width.height.equalTo(250)
    }
    
    tool2.snp.makeConstraints {
        $0.width.height.equalTo(250)
    }
    
    [tool, tool2].forEach {
        contentView.addArrangedSubview($0)
    }
    
    return contentView
}
