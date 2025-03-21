//
//  PopupView.swift
//  CokeZet-Components
//
//  Created by 김진우 on 3/7/25.
//

import UIKit
import CokeZet_DesignSystem

public final class PopupView: UIView {
    typealias ButtonState = Popup.State
    
    private let popupContentView: Popup = Popup()
    
    public struct State {
        let loginFlag: Bool
        let leftButtonAction: UIAction?
        let rightButtonAction: UIAction?
    }
    
    public init(_ state: State) {
        super.init(frame: .zero)
        addConfiguration()
        makeConstraints(state)
        bind(state)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConfiguration() {
        backgroundColor = ZetColor.Gray900.color.withAlphaComponent(0.6)
    }
    
    private func makeConstraints(_ state: State) {
        addSubview(popupContentView)
        
        popupContentView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(state.loginFlag ? 134 : 204)
        }
    }
    
    private func bind(_ state: State) {
        if state.loginFlag {
            popupContentView.bind(ButtonState(title: "로그아웃하시겠어요?",
                                              describe: nil,
                                              leftButtonTitle: "아니요",
                                              rightButtonTitle: "네",
                                              leftButtonAction: state.leftButtonAction,
                                              rightButtonAction: state.rightButtonAction))
        } else {
            popupContentView.bind(ButtonState(title: "ZET와의 최저가 탐색을 정말 \n그만두시겠어요?",
                                              describe: "확인 선택 시 바로 탈퇴됩니다.",
                                              leftButtonTitle: "취소",
                                              rightButtonTitle: "확인",
                                              leftButtonAction: state.leftButtonAction,
                                              rightButtonAction: state.rightButtonAction))
        }
    }
}

@available(iOS 17.0, *)
#Preview(
    "Popup",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = 10
    
    contentView.addSubview(stackView)
    
    stackView.snp.makeConstraints {
        $0.edges.equalToSuperview()
    }
    
    let quit_popupView = PopupView(
        PopupView.State(
            loginFlag: false,
            leftButtonAction: nil,
            rightButtonAction: nil)
    )
    
    let login_popupView = PopupView(
        PopupView.State(
            loginFlag: true,
            leftButtonAction: UIAction(handler: { _ in
                print(quit_popupView.bounds)
            }),
            rightButtonAction: nil)
    )
    
    [login_popupView, quit_popupView].forEach {
        stackView.addArrangedSubview($0)
        $0.snp.makeConstraints {
            $0.width.equalTo(400)
            $0.height.equalTo(204)
        }
    }
    
    return contentView
}
