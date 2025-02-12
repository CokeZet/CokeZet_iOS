//
//  BubblePopupButton.swift
//  CokeZet-Components
//
//  Created by 김진우 on 2/7/25.
//

import UIKit
import CokeZet_DesignSystem

public final class BubblePopupButton: UIButton {
    
    private var bubbleView: BubblePopupView?
    
    private var text = ""
    
    public init(_ text: String) {
        super.init(frame: .zero)
        self.setImage(.strokedCheckmark, for: .normal)
        self.tintColor = .black
        self.clipsToBounds = true
        self.text = text
        setButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButtonAction() {
        let touchUpAction = UIAction(handler: { [weak self] _ in
            guard let self else { return }
            if self.bubbleView == nil {
                self.showBubbleView()
            }
        })
        addAction(touchUpAction, for: .touchUpInside)
    }
    
    private func showBubbleView() {
        // BubblePopupView 생성 및 설정
        let bubbleView = BubblePopupView(text: text)
        self.bubbleView = bubbleView
        
        // BubblePopupView를 최상위 뷰에 추가
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.keyWindow })
            .first {
            window.addSubview(bubbleView)
        }
        
        // BubblePopupView 위치 설정
        bubbleView.snp.makeConstraints {
            $0.top.equalTo(self.snp.bottom).offset(12)
            $0.leading.equalTo(self.snp.leading).offset(-26)
        }
        
        // BubblePopupView 제거를 위한 탭 제스처 추가
        bubbleView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeBubbleView)))
    }
    
    @objc private func removeBubbleView() {
        bubbleView?.removeFromSuperview()
        bubbleView = nil
    }
}

@available(iOS 17.0, *)
#Preview(
    "button state",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    contentView.alignment = .fill
    contentView.spacing = 10
    contentView.backgroundColor = ZetColor.Gray800.color
    
    let tool = BubblePopupButton("내가 설정한 쇼핑몰 외의 사이트 최저가도 함께 갖고 왔어요.\n 카드 혜택의 경우 조건이 있을 수 있어요.")
    tool.snp.makeConstraints {
        $0.width.equalTo(20)
    }
    contentView.addArrangedSubview(tool)
    
    return contentView
}
