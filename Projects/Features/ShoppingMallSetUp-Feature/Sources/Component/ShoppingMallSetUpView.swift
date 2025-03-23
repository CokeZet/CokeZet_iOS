//
//  ShoppingMallSetUpView.swift
//  ShoppingMallSetUp-Feature
//
//  Created by Daye on 2/16/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class ShoppingMallSetUpView: UIView {

    private enum Metric {
        static let horizontalInset: CGFloat = 20
        static let topInset: CGFloat = 24
        static let bottomInset: CGFloat = 16
        static let pageHeight: CGFloat = 68
    }

    struct State {
        let nickname: String
        let list: [ShoppingMallListView.State]
        let selectConfirm: UIAction
    }

    private let pageLabel = ZetLabel(typography: .semiBold(.T20), textColor: .Gray600)
    private let titleLabel = ZetLabel(typography: .semiBold(.T24), textColor: .White)
    private let listView = ShoppingMallListView()
    private let confirmButton = ZetLargeButton(buttonState: .normal)

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
        self.pageLabel.text = "1/3"

        self.titleLabel.numberOfLines = 0
        
        self.confirmButton.setTitle("계속하기", for: .normal)
        self.confirmButton.setTitle("계속하기", for: .disabled)
    }

    private func makeConstraints() {
        self.addSubview(pageLabel)
        self.addSubview(titleLabel)
        self.addSubview(listView)
        self.addSubview(confirmButton)

        self.pageLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().offset(Metric.horizontalInset)
            $0.height.equalTo(Metric.pageHeight)
        }

        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.pageLabel.snp.bottom).offset(Metric.topInset)
            $0.horizontalEdges.equalToSuperview().inset(Metric.horizontalInset)
        }

        self.listView.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(Metric.topInset)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(self.confirmButton.snp.top).offset(-Metric.bottomInset)
        }

        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-Metric.bottomInset)
            $0.horizontalEdges.equalToSuperview().inset(Metric.horizontalInset)
        }
    }

    func bind(state: State) {
        self.titleLabel.text = "\(state.nickname) 님,\n어떤 쇼핑몰에서\n가격을 탐지할까요?"
        self.listView.bind(list: state.list)
        self.confirmButton.addAction(state.selectConfirm, for: .touchUpInside)
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {

    let contentView = UIView()
    let view = ShoppingMallSetUpView()

    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.width.equalTo(404)
        $0.edges.equalTo(contentView.safeAreaLayoutGuide)
    }
    view.backgroundColor = .Gray800

    view.bind(
        state: ShoppingMallSetUpView.State(
            nickname: "복슬복슬한반달가슴곰",
            list: [
                ShoppingMallListView.State(image: nil, title: "전체"),
                   ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icNaver.image, title: "네이버"),
                   ShoppingMallListView.State(image: CokeZetDesignSystemAsset.ic11st.image, title: "11번가"),
                   ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icCoupang.image, title: "쿠팡"),
                   ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icGmarket.image, title: "지마켓"),
                   ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icCurly.image, title: "마켓컬리"),
                   ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icNaver.image, title: "네이버"),
                   ShoppingMallListView.State(image: CokeZetDesignSystemAsset.icNaver.image, title: "네이버")
            ],
            selectConfirm: UIAction() { _ in
                print("클릭 클릭")
            }
        )
    )

    return contentView
}
