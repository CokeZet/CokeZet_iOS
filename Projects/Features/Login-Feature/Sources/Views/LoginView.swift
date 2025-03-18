//
//  LoginView.swift
//  Login-Feature
//
//  Created by Daye on 3/10/25.
//

import UIKit

import SnapKit

import CokeZet_DesignSystem

final class LoginView: UIView {

    private enum Metric {
        static let spacing: CGFloat = 16
        static let imageViewBottom: CGFloat = 24
        static let descriptionBottom: CGFloat = 20
        static let stackViewBottom: CGFloat = 20
    }

    private let imageView = UIImageView()
    private let descriptionLabel = UILabel()

    private let stackView = UIStackView()
    private let exploreButton = UIButton()
    private let kakaoButton = UIButton()
    private let appleButton = UIButton()

    var selectExplore: (() -> Void)?
    var selectKaKao: (() -> Void)?
    var selectApple: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.stackView.axis = .vertical
        self.stackView.spacing = Metric.spacing

        self.imageView.image = CokeZetDesignSystemAsset.icLoginBack.image

        self.setExploreButton()
        self.exploreButton.setTitleColor(.White, for: .normal)
        self.exploreButton.titleLabel?.font = Typography.medium(.T12).font

        self.kakaoButton.setImage(CokeZetDesignSystemAsset.icKakaoLogin.image, for: .normal)
        self.appleButton.setImage(CokeZetDesignSystemAsset.icAppleLogin.image, for: .normal)

        self.setButtonAction()
    }

    private func makeConstraints() {
        self.addSubview(imageView)
        self.addSubview(descriptionLabel)
        self.addSubview(stackView)

        self.stackView.addArrangedSubview(exploreButton)
        self.stackView.addArrangedSubview(appleButton)
        self.stackView.addArrangedSubview(kakaoButton)


        self.imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.descriptionLabel.snp.top).offset(-Metric.imageViewBottom)
        }

        self.descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.stackView.snp.top).offset(-Metric.descriptionBottom)
            $0.centerX.equalToSuperview()
        }

        self.stackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-Metric.stackViewBottom)
            $0.centerX.equalToSuperview()
        }
    }

    func setExploreButton() {
        let title = "비회원으로 둘러보기"
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        self.exploreButton.setAttributedTitle(attributedString, for: .normal)
    }

    func setButtonAction() {
        let exploreAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.selectExplore?()
        }
        self.exploreButton.addAction(exploreAction, for: .touchUpInside)

        let kakaoAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.selectKaKao?()
        }
        self.exploreButton.addAction(kakaoAction, for: .touchUpInside)

        let appleAction = UIAction { [weak self] _ in
            guard let self else { return }
            self.selectApple?()
        }
        self.exploreButton.addAction(appleAction, for: .touchUpInside)
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {
    let view = LoginView()
    view.backgroundColor = .Gray800

    return view
}
