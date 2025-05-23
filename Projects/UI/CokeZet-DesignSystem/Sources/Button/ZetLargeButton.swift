//
//  ZetLargeButton.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/23/25.
//

import UIKit

import SnapKit

/// Round Button 컴포넌트 정의
/// figma: https://www.figma.com/design/2Sd5HIV4AVqvFUEzNpbBgX/SD🥤?node-id=497-17519&t=m3eVZ1aeg9slpf2F-0
public final class ZetLargeButton: UIButton {

    private enum Metric {
        static let height: CGFloat = 65
        static let cornerRadius: CGFloat = height/2
    }

    public var buttonState: ButtonState {
        didSet {
            self.setButtonStyle(self.buttonState, normalColor: self.normalColor)
        }
    }

    private var normalColor: ButtonState.Color = .red

    public init(
        buttonState: ButtonState = .normal,
        normalColor: ButtonState.Color = .red
    ) {
        self.normalColor = normalColor
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
        self.titleLabel?.font = Typography.semiBold(.T18).font
        self.setButtonStyle(self.buttonState, normalColor: self.normalColor)
        self.setButtonAction()
    }

    private func makeConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(Metric.height)
        }
    }

    private func setButtonStyle(
        _ state: ButtonState,
        normalColor: ButtonState.Color
    ) {
        self.backgroundColor = state.backgroundColor(normalColor)
        self.setTitleColor(state.titleColor(normalColor), for: .normal)
        self.setTitleColor(state.titleColor(normalColor), for: .disabled)
        self.isEnabled = self.buttonState != .disabled
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
        if self.buttonState != .disabled {
            self.setButtonStyle(.pressed, normalColor: self.normalColor)
        }
    }

    private func handleTouchUp() {
        if self.buttonState != .disabled {
            self.setButtonStyle(self.buttonState, normalColor: self.normalColor)
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
        let button = ZetLargeButton(buttonState: state, normalColor: .gray)
        button.setTitle("타이틀 - \(state)", for: .normal)

        let action = UIAction(handler: { _ in
            print("\(state) clicked!")
        })
        button.addAction(action, for: .touchUpInside)
        
        button.snp.makeConstraints {
            $0.width.equalTo(334)
        }

        contentView.addArrangedSubview(button)
    }

    return contentView
}

@available(iOS 17.0, *)
#Preview(
    "button state_red",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    contentView.alignment = .center
    contentView.spacing = 10

    ButtonState.allCases.forEach { state in
        let button = ZetLargeButton(buttonState: state, normalColor: .red)
        button.setTitle("타이틀 - \(state)", for: .normal)

        let action = UIAction(handler: { _ in
            print("\(state) clicked!")
        })
        button.addAction(action, for: .touchUpInside)

        button.snp.makeConstraints {
            $0.width.equalTo(334)
        }

        contentView.addArrangedSubview(button)
    }

    return contentView
}

@available(iOS 17.0, *)
#Preview(
    "button state_white",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    contentView.alignment = .center
    contentView.spacing = 10

    ButtonState.allCases.forEach { state in
        let button = ZetLargeButton(buttonState: state, normalColor: .white)
        button.setTitle("타이틀 - \(state)", for: .normal)

        let action = UIAction(handler: { _ in
            print("\(state) clicked!")
        })
        button.addAction(action, for: .touchUpInside)

        button.snp.makeConstraints {
            $0.width.equalTo(334)
        }

        contentView.addArrangedSubview(button)
    }

    return contentView
}
