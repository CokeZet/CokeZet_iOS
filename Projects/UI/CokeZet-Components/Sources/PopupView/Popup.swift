//
//  Popup.swift
//  CokeZet-Components
//
//  Created by 김진우 on 3/7/25.
//

import UIKit
import Then
import SnapKit
import CokeZet_DesignSystem

public final class Popup: UIView {
    private let verticalStackView: UIStackView = UIStackView().then {
        $0.alignment = .fill
        $0.spacing = 16
        $0.axis = .vertical
        $0.distribution = .fill
    }
    
    private let titleLabel: ZetLabel = ZetLabel(typography: .extraBold(.T20), textColor: ZetColor.White.color).then {
        $0.textAlignment = .left
        $0.numberOfLines = 2
        $0.lineBreakStrategy = .hangulWordPriority
    }
    
    private let describeLabel: ZetLabel = ZetLabel(typography: .medium(.T16), textColor: ZetColor.Red600.color)
    
    private let leftButton: ZetMediumButton = ZetMediumButton(buttonState: .normal, normalColor: .white)
    
    private let rightButton: ZetMediumButton = ZetMediumButton(buttonState: .normal, normalColor: .gray)
    
    private let buttonStackView: UIStackView = UIStackView().then {
        $0.alignment = .center
        $0.spacing = 12
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    public struct State {
        let title: String
        let describe: String?
        let leftButtonTitle: String
        let rightButtonTitle: String
        let leftButtonAction: UIAction?
        let rightButtonAction: UIAction?
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
        addConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConfiguration() {
        backgroundColor = ZetColor.Gray700.color
        layer.cornerRadius = 16
    }
    
    private func makeConstraints() {
        addSubview(verticalStackView)
        
        [titleLabel, describeLabel, buttonStackView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        [leftButton, rightButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
    
    public func bind(_ state: State) {
        titleLabel.text = state.title
        
        if let describe = state.describe {
            describeLabel.text = describe
        } else {
            describeLabel.isHidden = true
        }
        
        leftButton.setTitle(state.leftButtonTitle, for: .normal)
        rightButton.setTitle(state.rightButtonTitle, for: .normal)
        
        guard let leftButtonAction = state.leftButtonAction else { return }
        leftButton.addAction(leftButtonAction, for: .touchUpInside)
        
        guard let rightButtonAction = state.rightButtonAction else { return }
        rightButton.addAction(rightButtonAction, for: .touchUpInside)
        
    }
}
