//
//  ZetRoundButton.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/23/25.
//

import UIKit

import SnapKit

public final class ZetRoundButton: UIButton {

    private enum Metric {
        static let width: CGFloat = 334
        static let height: CGFloat = 65
        static let size = CGSize(width: width, height: height)
        static let cornerRadius: CGFloat = height/2
    }

    private var buttonState: ButtonState {
        didSet {
            self.setButtonStyle(self.buttonState)
            self.isEnabled = self.buttonState == .Disabled
        }
    }

    init(buttonState: ButtonState = .Primary) {
        self.buttonState = buttonState
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.layer.cornerRadius = Metric.cornerRadius
        self.titleLabel?.font = Typography.T18.font
        self.setButtonStyle(self.buttonState)
        self.setButtonAction()
    }

    private func makeConstraints() {
        self.snp.makeConstraints {
            $0.size.equalTo(Metric.size)
        }
    }

    private func setButtonStyle(_ state: ButtonState) {
        self.backgroundColor = state.backgroundColor
        self.setTitleColor(state.titleColor, for: .normal)
    }

    private func setButtonAction() {
        let touchDownAction = UIAction(handler: { [weak self] _ in
            self?.handleTouchDown()
        })
        addAction(touchDownAction, for: .touchDown)

        let touchUpAction = UIAction(handler: { [weak self] _ in
            self?.handleTouchUp()
        })
        addAction(touchUpAction, for: [.touchUpInside, .touchCancel, .touchDragExit])
    }

    private func handleTouchDown() {
        if self.buttonState != .Disabled {
            self.setButtonStyle(.Pressed)
        }
    }

    private func handleTouchUp() {
        if self.buttonState != .Disabled {
            self.setButtonStyle(self.buttonState)
        }
    }
}

@available(iOS 17.0, *)
#Preview(
    "button state",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    contentView.alignment = .center
    contentView.spacing = 10

    ButtonState.allCases.forEach { state in
        let button = ZetRoundButton(buttonState: state)
        button.setTitle("타이틀 - \(state)", for: .normal)

        let action = UIAction(handler: { _ in
            print("\(state) clicked!")
        })
        button.addAction(action, for: .touchUpInside)

        contentView.addArrangedSubview(button)
    }

    return contentView
}
