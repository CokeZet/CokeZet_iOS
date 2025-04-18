//
//  NicknameSettingView.swift
//  Nickname-Feature
//
//  Created by Daye on 1/24/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

internal final class NicknameSettingView: UIView {
    
    private enum Metric {
        static let topInset: CGFloat = 88
        static let bottomInset: CGFloat = 17
        static let leadingInset: CGFloat = 20
        static let spacing: CGFloat = 24
        static let pageHeight: CGFloat = 68
    }
    
    struct State {
        let defaultNickname: String
        let selectConfirm: UIAction
    }
    
    private let pageLabel = ZetLabel(typography: .semiBold(.T20), textColor: .Gray600)
    private let stackView = UIStackView()
    private let nickNameinputView = NicknameInputView()
    private let descriptionLabel = ZetLabel(typography: .semiBold(.T24), textColor: .White)
    private let confirmButton = ZetLargeButton(buttonState: .disabled)
    
    private var confirmButtonBottomConstraint: Constraint?
    
    internal init() {
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
        self.addKeyboardDismissGesture()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConfigure() {
        self.pageLabel.text = "1/3"
        
        self.backgroundColor = .Gray800
        
        self.stackView.axis = .vertical
        self.stackView.spacing = Metric.spacing
        
        self.descriptionLabel.numberOfLines = 2
        self.descriptionLabel.text = "몇 가지 더 설정하고\n함께 최저가 콜라 즐겨요!"
        self.descriptionLabel.textAlignment = .left
        
        self.nickNameinputView.isVaild = { isValid in
            let state: ButtonState = isValid ? .normal : .disabled
            
            self.confirmButton.buttonState = state
        }
        
        self.confirmButton.setTitle("다음", for: .normal)
    }
    
    private func makeConstraints() {
        self.addSubview(pageLabel)
        self.addSubview(stackView)
        self.stackView.addArrangedSubview(nickNameinputView)
        self.stackView.addArrangedSubview(descriptionLabel)
        
        self.addSubview(confirmButton)
        
        self.pageLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().offset(Metric.leadingInset)
            $0.height.equalTo(Metric.pageHeight)
        }
        
        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.pageLabel.snp.bottom).offset(Metric.topInset)
            $0.leading.equalToSuperview().offset(Metric.leadingInset)
        }
        
        self.confirmButton.snp.makeConstraints {
            self.confirmButtonBottomConstraint = $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-Metric.bottomInset).constraint
            $0.horizontalEdges.equalToSuperview().inset(Metric.leadingInset)
        }
    }
    
    func bind(state: State) {
        self.nickNameinputView.setDefaultNickname(state.defaultNickname)
        self.confirmButton.addAction(state.selectConfirm, for: .touchUpInside)
    }
    
    private func addKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // 버튼 등 다른 터치 이벤트도 동작하도록 설정
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    /// 키보드 높이에 따라 버튼의 위치를 조정하는 함수
    func updateButtonForKeyboard(keyboardHeight: CGFloat, animationDuration: Double = 0.3) {
        // 키보드가 올라올 때, 버튼을 키보드 위로 10px 띄워줌
        let bottomInset = keyboardHeight > 0 ? keyboardHeight + 10 : Metric.bottomInset
        self.confirmButtonBottomConstraint?.update(offset: -bottomInset)
        UIView.animate(withDuration: animationDuration) {
            self.layoutIfNeeded()
        }
    }

}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    
    let view = NicknameSettingView()
    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.edges.equalToSuperview()
        $0.width.equalTo(404)
    }
    
    view.bind(state: NicknameSettingView.State(
        defaultNickname: "복슬복슬한반달가슴곰",
        selectConfirm: UIAction() { _ in
            print("버튼 클릭클릭")
        }
    ))
    
    return contentView
}


