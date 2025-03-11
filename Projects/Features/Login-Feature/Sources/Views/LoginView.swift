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

        self.exploreButton.setTitle("비회원으로 둘러보기", for: .normal)
        self.exploreButton.setTitleColor(.White, for: .normal)
        self.exploreButton.titleLabel?.font = Typography.medium(.T12).font

        self.kakaoButton.setImage(CokeZetDesignSystemAsset.icKakaoLogin.image, for: .normal)
        self.appleButton.setImage(CokeZetDesignSystemAsset.icAppleLogin.image, for: .normal)
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
