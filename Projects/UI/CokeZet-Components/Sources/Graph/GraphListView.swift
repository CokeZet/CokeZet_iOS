//
//  GraphListView.swift
//  CokeZet-Components
//
//  Created by 김진우 on 4/21/25.
//

import UIKit

import SnapKit
import CokeZet_DesignSystem

class GraphListView: UIView {

    // MARK: - UI Properties
    // 배경 트랙 뷰 (어두운 회색)
    private lazy var trackView = UIView().then {
        $0.backgroundColor = UIColor.darkGray.withAlphaComponent(0.5) // 색상 조정 필요
        $0.layer.cornerRadius = 12 // 높이에 따라 조절
        $0.layer.masksToBounds = true
    }

    // 인디케이터 (동그라미) 스택 뷰
    private lazy var indicatorStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing // 균등 간격 배치
        $0.alignment = .center
    }

    // 라벨 스택 뷰
    private lazy var labelStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually // 각 라벨이 동일 너비 차지
        $0.alignment = .center
    }

    // 하이라이트 뷰 (그라데이션)
    private lazy var highlightView = BadgeDiscountRateView()

    private var segmentType: [DiscountRateType] = DiscountRateType.allCases
    
    private var indicatorViews: [UIView] = [] // 인디케이터 뷰 저장
    private var segmentLabels: [UILabel] = [] // 라벨 뷰 저장

    // 현재 선택된 인덱스 (외부에서 접근 가능)
    var selectedIndex: DiscountRateType = .normal {
        didSet {
            highlightView.setType(selectedIndex, .Cricle)
            updateHighlightPosition(selectedIndex: segmentType.enumerated().filter { $0.element == selectedIndex }.first?.offset ?? 0, animated: true)
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupSegmentedControl()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        // self가 컨테이너 역할을 하므로 바로 서브뷰 추가
        addSubview(trackView)
        addSubview(labelStackView)
        trackView.addSubview(indicatorStackView) // 인디케이터는 트랙 안에
        addSubview(highlightView) // 하이라이트는 트랙 위에
        bringSubviewToFront(highlightView) // 시각적으로 위에 오도록
    }

    private func setupConstraints() {
        // 트랙 뷰
        trackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview() // self의 상단, 좌우에 맞춤
            $0.height.equalTo(24) // 트랙 높이
        }

        // 인디케이터 스택 뷰 (트랙 내부에 패딩을 주어 배치)
        indicatorStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(32) // 트랙 좌우 패딩
            $0.height.equalTo(12) // 인디케이터 높이 (동그라미 지름)
        }

        // 라벨 스택 뷰 (트랙 아래에 배치)
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(trackView.snp.bottom).offset(10) // 트랙 아래 간격
            $0.leading.trailing.equalTo(trackView) // 트랙과 동일한 너비
            $0.bottom.equalToSuperview() // self의 바닥에 붙임 (이 뷰의 전체 높이를 결정)
        }

        // 하이라이트 뷰 (초기 위치 설정, 추후 updateHighlightPosition에서 업데이트)
        highlightView.snp.makeConstraints {
            $0.centerY.equalTo(trackView) // 트랙과 수직 중앙 정렬
            $0.height.equalTo(trackView)   // 트랙과 동일 높이
            // 너비는 전체 너비의 1/N (세그먼트 개수)
            $0.width.equalTo(trackView).dividedBy(segmentType.count)
            // 초기 위치는 왼쪽으로 설정 (updateHighlightPosition에서 조정됨)
            $0.leading.equalTo(trackView)
        }
    }

    private func setupSegmentedControl() {
        guard !segmentType.isEmpty else { return }

        // 인디케이터 생성
        for _ in 0..<segmentType.count {
            let indicator = UIView().then {
                $0.backgroundColor = UIColor.black.withAlphaComponent(0.7)
                $0.layer.cornerRadius = 6
                $0.snp.makeConstraints { make in
                    make.width.height.equalTo(10)
                }
            }
            indicatorViews.append(indicator)
            indicatorStackView.addArrangedSubview(indicator)
        }

        // 라벨 생성
        for type in segmentType {
            let label = ZetLabel(typography: .medium(.T12), textColor: .Gray600)
            label.text = type.text
            label.textAlignment = .center
            segmentLabels.append(label)
            labelStackView.addArrangedSubview(label)
        }
        
        highlightView.snp.makeConstraints {
            $0.centerY.equalTo(trackView)
            $0.height.equalTo(trackView)
            $0.width.equalTo(trackView).dividedBy(segmentType.count)
            $0.leading.equalTo(trackView)
        }
    }

    // MARK: - Public Methods

    // 하이라이트 위치 업데이트
    func updateHighlightPosition(selectedIndex: Int, animated: Bool) {
        guard selectedIndex >= 0 && selectedIndex < segmentType.count else { return }
        guard !segmentType.isEmpty else { return }

        let duration = animated ? 0.3 : 0.0

        highlightView.snp.remakeConstraints {
            $0.centerY.centerX.equalTo(indicatorViews[selectedIndex])
            $0.height.equalTo(indicatorViews[selectedIndex])
            $0.width.equalTo(trackView).dividedBy(segmentType.count)
        }

        // 애니메이션 블록
        UIView.animate(withDuration: duration) {
            self.layoutIfNeeded()
        }
    }
    
}
