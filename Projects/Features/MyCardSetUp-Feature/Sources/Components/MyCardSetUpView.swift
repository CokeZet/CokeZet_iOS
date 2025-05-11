//
//  MyCardSetUpView.swift
//  MyCardSetUp-Feature
//
//  Created by Daye on 2/18/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit

final class MyCardSetUpView: UIView {

    private enum Metric {
        static let horizontalInset: CGFloat = 20
        static let topInset: CGFloat = 24
        static let bottomInset: CGFloat = 16
        static let descriptionInset: CGFloat = 15
        static let pageHeight: CGFloat = 68
    }

    struct State {
        let list: [MyCardListView.State]
        let confirmAction: UIAction
    }

    private let pageLabel = ZetLabel(typography: .semiBold(.T20), textColor: .Gray600)
    private let titleLabel = ZetLabel(typography: .semiBold(.T24), textColor: .White)
    private let listView = MyCardListView()
    private let descriptionLabel = ZetLabel(typography: .medium(.T12), textColor: .Gray500)
    private let confirmButton = ZetLargeButton(buttonState: .disabled)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConfigure()
        self.makeConstraints()
        self.bindSelectionEvent()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addConfigure() {
        self.pageLabel.text = "3/3"

        self.titleLabel.numberOfLines = 0
        self.titleLabel.text = "어떤 카드의\n할인 혜택 알림을\n받아볼까요?"

        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.textAlignment = .center
        self.descriptionLabel.text = "선택한 정보는 ZET 홈의 '최저가 탐색 조건 설정'에서\n언제든 변경할 수 있어요."

        self.confirmButton.setTitle("완료", for: .normal)
        self.confirmButton.setTitle("완료", for: .disabled)
    }

    private func makeConstraints() {
        self.addSubview(pageLabel)
        self.addSubview(titleLabel)
        self.addSubview(listView)
        self.addSubview(descriptionLabel)
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
            $0.bottom.equalTo(self.descriptionLabel.snp.top).offset(-Metric.bottomInset)
        }

        self.confirmButton.snp.makeConstraints {
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-Metric.bottomInset)
            $0.horizontalEdges.equalToSuperview().inset(Metric.horizontalInset)
        }

        self.descriptionLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.confirmButton.snp.top).offset(-Metric.descriptionInset)
            $0.horizontalEdges.equalToSuperview()

        }
    }
    
    private func bindSelectionEvent() {
        self.listView.onSelectionChanged = { [weak self] hasSelection in
            self?.confirmButton.buttonState = hasSelection ? .normal : .disabled
        }
    }

    func bind(state: State) {

        self.listView.bind(list: state.list)
        self.confirmButton.addAction(state.confirmAction, for: .touchDown)
    }
    
    func getSelectList() -> [Int] {
        return self.listView.getSelectList().map{$0 + 1}
    }
}

@available(iOS 17.0, *)
#Preview(
    "normal",
    traits: .sizeThatFitsLayout
) {

    let contentView = UIView()
    let view = MyCardSetUpView()

    contentView.addSubview(view)
    view.snp.makeConstraints {
        $0.width.equalTo(404)
        $0.edges.equalTo(contentView.safeAreaLayoutGuide)
    }
    view.backgroundColor = .Gray800

    view.bind(
        state: MyCardSetUpView.State(
            list: [
                MyCardListView.State(image: nil, title: "전체"),
                MyCardListView.State(image: CokeZetDesignSystemAsset.icNh.image, title: "농협"),
                MyCardListView.State(image: CokeZetDesignSystemAsset.icKb.image, title: "국민"),
                MyCardListView.State(image: CokeZetDesignSystemAsset.icShinhan.image, title: "신한"),
                MyCardListView.State(image: CokeZetDesignSystemAsset.icLotteCard.image, title: "롯데"),
                MyCardListView.State(image: CokeZetDesignSystemAsset.icHana.image, title: "하나"),
                MyCardListView.State(image: CokeZetDesignSystemAsset.icSamsung.image, title: "삼성"),
                MyCardListView.State(image: CokeZetDesignSystemAsset.icHyundai.image, title: "현대"),
            ], confirmAction: UIAction() { _ in
                print("클릭 클릭")
            }
        )
    )

    return contentView
}
