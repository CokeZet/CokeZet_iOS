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

    private enum Constant {
        static let maxCount = 10
    }

    private enum Metric {
        static let textFieldWidth: CGFloat = 210
        static let hStackSpacing: CGFloat = 8
        static let vStackSpacing: CGFloat = 12
        static let underLineHeight: CGFloat = 1
    }

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
        $0.textAlignment = .center
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

    private func addConfigure() {
        self.textField.delegate = self
    }

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

    func setDefaultNickname(_ text: String) {
        self.textField.text = text
    }
}

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

        countLabel.text = "\(length)/\(Constant.maxCount)"

        if length > Constant.maxCount {
            textField.text = String(text.precomposedStringWithCanonicalMapping.prefix(Constant.maxCount))
        }

        self.isVaild?(length > 0)
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


