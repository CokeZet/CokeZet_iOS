//
//  RollingLabel.swift
//  CokeZet-Components
//
//  Created by 김진우 on 2/27/25.
//

import UIKit

import CokeZet_DesignSystem

/// 사용하실 때 Label을 감싸주는 View를 넣고, clipsToBounds를 true로 설정해주면 박스를 벗어나지 않는 액션을 볼 수 있습니다.
public class RollingLabel: ZetLabel {
    private var textList: [String] = []
    
    private var timer: Timer = Timer()
    
    private var index: Int = 0
    
    private var duration: CGFloat
    
    public init(
        textList: [String],
        typography: Typography,
        textColor: UIColor = .Basic222222,
        duration: CGFloat = 3
    ) {
        self.duration = duration
        super.init(typography: typography, textColor: textColor)
        self.textList = textList
        self.text = textList[0]
        self.index = textList.count < 2 ? 0 : 1
        self.rollingAnimation()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func rollingAnimation() {
        timer = Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(rollingTextAnimation), userInfo: nil, repeats: true)
    }

    @objc private func rollingTextAnimation() {
        let transition = CATransition()
        transition.duration = 1
        transition.timingFunction = .init(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromTop
        self.layer.add(transition, forKey: CATransitionType.push.rawValue)
        
        UIView.transition(with: self,
                          duration: 1,
                          options: .allowUserInteraction,
                          animations: { [weak self] in
            guard let self else { return }
            if index >= textList.count {
                index = 0
            }
            
            self.text = self.textList[index]
            index += 1
        },
                          completion: nil)
    }

    
}

@available(iOS 17.0, *)
#Preview(
    "rolling",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    let text = ["100ml당 가격이 낮은 순으로 소개해 드려요.", "배송비가 있는 경우 가격에 포함하여 알려드려요."]
    let labelT24 = RollingLabel(
        textList: text,
        typography: .medium(.T16),
        textColor: .Basic666666,
        duration: 3
    )

    contentView.addArrangedSubview(labelT24)

    return contentView
}
