//
//  NicknameInputView.swift
//  Nickname-Feature
//
//  Created by Daye on 1/24/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

internal final class NicknameInputView: UIView {

    // 최대 글자수 및 레이아웃 관련 상수 정의
    private enum Constant {
        static let maxCount = 10
    }

    private enum Metric {
        static let textFieldWidth: CGFloat = 210
        static let hStackSpacing: CGFloat = 8
        static let vStackSpacing: CGFloat = 12
        static let underLineHeight: CGFloat = 1
    }

    // 색상 상수 정의
    private enum Color {
        static let normal = UIColor.White
        static let error = UIColor.red
        static let countText = UIColor.Gray500
    }

    // 닉네임 입력 필드와 UI 구성요소 선언
    private let hStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = Metric.hStackSpacing
        $0.alignment = .top
    }
    private let textField = UITextField().then {
        $0.backgroundColor = .clear
        $0.textColor = .White
        $0.font = Typography.semiBold(.T24).font
        $0.borderStyle = .none
        $0.tintColor = .White
        $0.textAlignment = .left
    }
    private let underLineView = UIView().then {
        $0.backgroundColor = .White
    }
    private let sirLabel = ZetLabel(typography: .semiBold(.T24), textColor: .BasicFFFFFF).then {
        $0.text = "님,"
    }

    private let vStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = Metric.vStackSpacing
        $0.alignment = .leading
    }
    private let countLabel = ZetLabel(typography: .semiBold(.T14), textColor: .Gray500).then {
        $0.text = "0/\(Constant.maxCount)"
    }

    // 닉네임 유효성 콜백
    var isVaild: ((Bool) -> ())?

    internal init() {
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 텍스트필드 델리게이트 설정
    private func addConfigure() {
        self.textField.delegate = self
    }

    // 오토레이아웃 설정
    private func makeConstraints() {
        self.textField.addSubview(underLineView)

        self.hStackView.addArrangedSubview(textField)
        self.hStackView.addArrangedSubview(sirLabel)

        self.vStackView.addArrangedSubview(hStackView)
        self.vStackView.addArrangedSubview(countLabel)

        self.addSubview(vStackView)

        self.vStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.textField.snp.makeConstraints {
            $0.width.equalTo(Metric.textFieldWidth)
        }
        self.underLineView.snp.makeConstraints {
            $0.height.equalTo(Metric.underLineHeight)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    // 닉네임 기본값 설정
    func setDefaultNickname(_ text: String) {
        self.textField.text = text
        updateUIForInput(text)
    }

    // MARK: - 특수문자, 이모티콘 포함 여부 검사 함수
    private func containsInvalidCharacters(_ text: String) -> Bool {
        // 한글(완성형+자모), 영문, 숫자만 허용 (정규식)
        let pattern = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]*$"
        return !NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: text)
    }

    // MARK: - 입력에 따른 UI 업데이트 함수
    private func updateUIForInput(_ text: String) {
        let length = text.precomposedStringWithCanonicalMapping.count

        if containsInvalidCharacters(text) {
            // 특수문자/이모티콘 입력시 에러 메시지 및 빨간색 표시
            countLabel.text = "특수문자, 이모티콘은 입력할 수 없어요."
            countLabel.textColor = Color.error
            underLineView.backgroundColor = Color.error
            self.isVaild?(false)
        } else {
            // 정상 입력시 글자수 및 흰색 스타일
            countLabel.text = "\(length)/\(Constant.maxCount)"
            countLabel.textColor = Color.countText
            underLineView.backgroundColor = Color.normal
            self.isVaild?(length > 0)
        }
    }
}

// MARK: - UITextFieldDelegate 구현
extension NicknameInputView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        // 공백 입력 차단
        return !string.contains(" ")
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        let length = text.precomposedStringWithCanonicalMapping.count

        // 최대 글자수 초과시 자동 자르기
        if length > Constant.maxCount {
            let trimmed = String(text.precomposedStringWithCanonicalMapping.prefix(Constant.maxCount))
            textField.text = trimmed
            updateUIForInput(trimmed)
        } else {
            updateUIForInput(text)
        }
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIView()
    contentView.backgroundColor = .black

    let view = NicknameInputView()
    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.edges.equalToSuperview()
    }

    view.setDefaultNickname("행복한강아지")

    return contentView
}
