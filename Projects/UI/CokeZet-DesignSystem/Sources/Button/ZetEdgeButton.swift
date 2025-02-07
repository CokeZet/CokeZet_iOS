//
//  ZetButton.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 1/23/25.
//

import UIKit

import SnapKit

/// Edge Button 컴포넌트 정의
/// figma: https://www.figma.com/design/2Sd5HIV4AVqvFUEzNpbBgX/SD🥤?node-id=497-17519&t=m3eVZ1aeg9slpf2F-0
public final class ZetEdgeButton: UIButton {

    private enum Metric {
        static let height: CGFloat = 48
        static let cornerRadius: CGFloat = 10
    }

    private let size: EdgeButtonSize
    public var buttonState: ButtonState {
        didSet {
            self.setButtonStyle(self.buttonState)
        }
    }

    public init(
        size: EdgeButtonSize = .Default,
        buttonState: ButtonState = .Primary
    ) {
        self.size = size
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
            $0.width.equalTo(self.size.width)
            $0.height.equalTo(Metric.height)
        }
    }

    private func setButtonStyle(_ state: ButtonState) {
        self.backgroundColor = state.backgroundColor
        self.setTitleColor(state.titleColor, for: .normal)
        self.isEnabled = self.buttonState != .Disabled
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
        let button = ZetEdgeButton(size: .Default, buttonState: state)
        button.setTitle("타이틀 - \(state)", for: .normal)

        let action = UIAction(handler: { _ in
            print("\(state) clicked!")
        })
        button.addAction(action, for: .touchUpInside)

        contentView.addArrangedSubview(button)
    }

    return contentView
}

@available(iOS 17.0, *)
#Preview(
    "button size",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    contentView.alignment = .center
    contentView.spacing = 10

    EdgeButtonSize.allCases.forEach { size in
        let button = ZetEdgeButton(size: size, buttonState: .Primary)
        button.setTitle("타이틀 - \(size)", for: .normal)

        let action = UIAction(handler: { _ in
            print("\(size) clicked!")
        })
        button.addAction(action, for: .touchUpInside)

        contentView.addArrangedSubview(button)
    }

    return contentView
}


