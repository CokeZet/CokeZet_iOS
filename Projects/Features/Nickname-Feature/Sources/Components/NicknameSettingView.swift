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
    }

    struct State {
        let defaultNickname: String
    }

    private let stackView = UIStackView()
    private let nickNameinputView = NicknameInputView()
    private let descriptionLabel = ZetLabel(typography: .T24, textColor: .White)
    private let confirmButton = ZetRoundButton(buttonState: .Primary)

    internal init() {
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.backgroundColor = .Gray800

        self.stackView.axis = .vertical
        self.stackView.spacing = Metric.spacing
        self.stackView.alignment = .leading

        self.descriptionLabel.numberOfLines = 2
        self.descriptionLabel.text = "몇 가지 더 설정하고\n함께 최저가 콜라 즐겨요!"
        self.descriptionLabel.textAlignment = .left
        self.confirmButton.setTitle("다음", for: .normal)
        self.nickNameinputView.isVaild = { isValid in
            // TODO: 추후 버튼 컴포넌트 업데이트 시 수정 필요
            let state: ButtonState = isValid ? .Primary : .Disabled

            self.confirmButton.buttonState = state
        }
    }

    private func makeConstraints() {
        self.addSubview(stackView)
        self.stackView.addArrangedSubview(nickNameinputView)
        self.stackView.addArrangedSubview(descriptionLabel)

        self.addSubview(confirmButton)

        self.stackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(Metric.topInset)
            $0.leading.equalToSuperview().offset(Metric.leadingInset)
        }

        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-Metric.bottomInset)
            $0.centerX.equalToSuperview()
        }
    }

    func bind(state: State) {
        self.nickNameinputView.setDefaultNickname(state.defaultNickname)
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
    }

    view.bind(state: NicknameSettingView.State(defaultNickname: "복슬복슬한반달가슴곰"))

    return contentView
}


