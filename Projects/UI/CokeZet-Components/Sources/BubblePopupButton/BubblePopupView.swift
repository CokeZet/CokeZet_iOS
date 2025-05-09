//
//  BubblePopupView.swift
//  CokeZet-Components
//
//  Created by 김진우 on 2/7/25.
//

import UIKit
import CokeZet_DesignSystem

public final class BubblePopupView: UIView {
    // 텍스트를 표시할 UILabel
    public let textLabel = ZetLabel(typography: .medium(.T12), textColor: .White).then {
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    
    private var location: BubblePopupLocation
    
    public init(text: String, location: BubblePopupLocation) {
        self.location = location
        super.init(frame: .zero)
        addConfigure(text: text)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConfigure(text: String) {
        textLabel.setAttributed(
            text: text,
            font: Typography.medium(.T12).font,
            color: .white,
            letterSpacing: -0.02,
            lineHeight: 18,
            textAlignment: .left,
            lineBreakMode: .byTruncatingTail,
            hasStrikeThrough: false,
            hasUnderline: false
        )
        
        // 말풍선 배경 색상
        backgroundColor = .Gray500
        layer.cornerRadius = 6
        clipsToBounds = false
    }
    
    private func makeConstraints() {
        // 텍스트 레이블 추가
        addSubview(textLabel)
        
        textLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(6)
        }
    }
    
    public func setText(_ text: String) {
        textLabel.setAttributed(
            text: text,
            font: Typography.medium(.T12).font,
            color: .white,
            letterSpacing: -0.02,
            lineHeight: 18,
            textAlignment: .left,
            lineBreakMode: .byTruncatingTail,
            hasStrikeThrough: false,
            hasUnderline: false
        )
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        addBubbleTail()
    }
    
    private func addBubbleTail() {
        // 기존 꼬리 제거
        layer.sublayers?.removeAll(where: { $0 is CAShapeLayer })
        
        // 꼬리 모양을 그릴 CAShapeLayer 생성
        let bubbleTail = CAShapeLayer()
        let tailPath = UIBezierPath()
        
        // 꼬리 크기 설정
        let tailWidth: CGFloat = 12
        let tailHeight: CGFloat = 8
        let curveRadius: CGFloat = 1 // 꼬리 끝의 둥글기 반경
        
        // 꼬리의 시작점 (말풍선 위쪽 중앙)
        let startX: CGFloat = location == .left ? 30 : self.bounds.width - 30
        let startY: CGFloat = 0.0 // 말풍선의 위쪽 경계선
        
        // 꼬리 그리기
        tailPath.move(to: CGPoint(x: startX, y: startY)) // 왼쪽 시작점
        
        // 왼쪽 직선
        tailPath.addLine(to: CGPoint(x: startX + tailWidth / 2 - curveRadius, y: startY - tailHeight))
        
        // 끝부분을 둥글게 처리 (왼쪽에서 오른쪽으로 곡선)
        tailPath.addQuadCurve(
            to: CGPoint(x: startX + tailWidth / 2 + curveRadius, y: startY - tailHeight), // 곡선 끝점
            controlPoint: CGPoint(x: startX + tailWidth / 2, y: startY - tailHeight - curveRadius) // 곡선의 제어점 (꼬리 끝 중앙)
        )
        
        // 오른쪽 직선
        tailPath.addLine(to: CGPoint(x: startX + tailWidth, y: startY))
        
        tailPath.close() // 경로 닫기
        
        // 꼬리 색상 설정
        bubbleTail.path = tailPath.cgPath
        bubbleTail.fillColor = backgroundColor?.cgColor // 말풍선 배경색과 동일하게 설정
        
        // 꼬리 레이어 추가
        layer.addSublayer(bubbleTail)
    }
}


@available(iOS 17.0, *)
#Preview(
    "button state",
    traits: .sizeThatFitsLayout
) {
    let popupView = BubblePopupView(text: "내가 설정한 쇼핑몰 외의 사이트 최저가도 함께 갖고 왔어요. 카드 혜택의 경우 조건이 있을 수 있어요.", location: .left)
    
    let maxWidth: CGFloat = 293        // 말풍선의 최대 너비
    
    let textSize = popupView.textLabel.sizeThatFits(CGSize(width: maxWidth - 8 * 2, height: CGFloat.greatestFiniteMagnitude))
    
    let bubbleWidth = textSize.width + 8 * 2
    
    popupView.snp.makeConstraints {
        $0.width.equalTo(bubbleWidth)
    }
    
    print(bubbleWidth)
    
    return popupView
}
