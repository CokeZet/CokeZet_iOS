//
//  GraphView.swift
//  CokeZet-Components
//
//  Created by 김진우 on 2/5/25.
//

import UIKit
import CokeZet_DesignSystem

import SnapKit

public final class GraphView: UICollectionViewCell {
    // 그래프 데이터 모델
    struct PriceData {
        let price: Int
        let date: String
    }

    // 그래프 데이터 배열
    private var priceData: [PriceData] = [
        PriceData(price: 11500, date: "23.11.07"),
        PriceData(price: 11000, date: "23.11.12"),
        PriceData(price: 13000, date: "23.11.28")
    ]

    // 그래프를 그릴 뷰
    private let graphView = UIView()
    
    private let titleLabel: UILabel = UILabel().then {
        $0.text = "최저가 그래프"
        $0.font = Typography.T18.font
        $0.textColor = .White
    }

    private var isGraphDrawn = false // 그래프가 이미 그려졌는지 확인하는 플래그

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // 상단 버튼 컨테이너
        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .equalSpacing
        buttonStackView.alignment = .center
        buttonStackView.spacing = 8
        buttonStackView.layer.backgroundColor = UIColor.Gray900.cgColor
        buttonStackView.layer.cornerRadius = 24
        
        let emptyView = UIView()
        buttonStackView.addArrangedSubview(emptyView)
        // 버튼 추가
        let periods = ["1개월", "3개월", "6개월"]
        for (index, period) in periods.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(period, for: .normal)
            button.setTitleColor(index == 0 ? .White : .Gray600, for: .normal)
            button.backgroundColor = index == 0 ? .Gray700 : .clear
            button.layer.cornerRadius = 16
            button.tag = index
            button.addTarget(self, action: #selector(periodButtonTapped(_:)), for: .touchUpInside)
            button.snp.makeConstraints {
                $0.height.equalTo(32)
                $0.width.equalTo((self.bounds.width - 40 - (8 * 4)) / 3 )
            }
            buttonStackView.addArrangedSubview(button)
        }
        let emptyView2 = UIView()
        buttonStackView.addArrangedSubview(emptyView2)
        
        [titleLabel, buttonStackView].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        // 버튼 스택뷰 추가 및 레이아웃 설정
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(48)
        }

        // 그래프 뷰 추가 및 레이아웃 설정
        addSubview(graphView)
        graphView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().offset(-55)
            make.height.equalTo(200)
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // 레이아웃이 완료된 후에 한 번만 그래프를 그림
        if !isGraphDrawn {
            drawGraph()
            isGraphDrawn = true
        }
    }

    private func drawGraph() {
        // 그래프 뷰 초기화
        graphView.subviews.forEach { $0.removeFromSuperview() }
        graphView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

        // 그래프 경계
        let graphWidth = graphView.bounds.width
        let graphHeight = graphView.bounds.height - 100

        // 가격 범위 계산
        guard let minPrice = priceData.map({ $0.price }).min(),
              let maxPrice = priceData.map({ $0.price }).max() else { return }
        
        // 그래프 상단과 하단에 여백 추가 (10% 여유)
        let padding: CGFloat = 0.1
        let adjustedMinPrice = CGFloat(minPrice) - CGFloat(minPrice) * padding
        let adjustedMaxPrice = CGFloat(maxPrice) + CGFloat(maxPrice) * padding
        let priceRange = adjustedMaxPrice - adjustedMinPrice

        // 데이터 간 간격 계산
        let pointSpacing = graphWidth / CGFloat(priceData.count - 1)

        // 그래프 선을 그릴 경로
        let path = UIBezierPath()

        // 최저가 점 저장
        var minPricePoint: CGPoint?

        for (index, data) in priceData.enumerated() {
            // x, y 좌표 계산
            let xPosition = CGFloat(index) * pointSpacing
            var yPosition = graphHeight - ((CGFloat(data.price) - adjustedMinPrice) / priceRange * graphHeight)

            // 최저가 점을 하단에서 50px 위로 이동
            if data.price == minPrice {
                yPosition = graphHeight
                minPricePoint = CGPoint(x: xPosition, y: yPosition)
            }

            let point = CGPoint(x: xPosition, y: yPosition)
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }

            // 데이터 점 추가 (원)
            let circle = UIView()
            circle.backgroundColor = .Gray800 // 원 내부 색상 설정
            circle.layer.borderColor = UIColor.Purple500.cgColor
            circle.layer.borderWidth = 2
            circle.layer.cornerRadius = 4
            graphView.addSubview(circle)
            circle.snp.makeConstraints { make in
                make.centerX.equalTo(xPosition)
                make.centerY.equalTo(yPosition)
                make.width.height.equalTo(8)
            }
            
            // 날짜 레이블 추가
            let dateLabel = UILabel()
            dateLabel.text = data.date
            dateLabel.font = Typography.T12.font
            dateLabel.textColor = .Gray500
            dateLabel.layer.cornerRadius = 4
            dateLabel.layer.backgroundColor = UIColor.Gray700.cgColor
            dateLabel.textAlignment = .center
            graphView.addSubview(dateLabel)
            dateLabel.snp.makeConstraints { make in
                make.centerX.equalTo(xPosition)
                make.width.equalTo(55)
                make.height.equalTo(20)
                make.bottom.equalTo(graphView.snp.bottom).inset(10)
            }

            // 가격 레이블 추가
            let priceLabel = UILabel()
            priceLabel.text = String(data.price).formatWithComma() + "원"
            priceLabel.font = Typography.T14.font
            priceLabel.textColor = data.price == minPrice ? .Purple500 : .Gray300
            priceLabel.sizeToFit()
            graphView.addSubview(priceLabel)
            priceLabel.snp.makeConstraints { make in
                make.centerX.equalTo(xPosition)
                make.bottom.equalTo(dateLabel.snp.top).offset(-8)
            }
        }

        // 최저가 점에서 바닥까지 이어지는 선 추가
        if let minPricePoint = minPricePoint {
            let verticalLinePath = UIBezierPath()
            verticalLinePath.move(to: minPricePoint)
            verticalLinePath.addLine(to: CGPoint(x: minPricePoint.x, y: graphHeight + 35))

            let verticalLineLayer = CAShapeLayer()
            verticalLineLayer.path = verticalLinePath.cgPath
            verticalLineLayer.strokeColor = UIColor.Purple500.cgColor
            verticalLineLayer.lineWidth = 1
            verticalLineLayer.lineDashPattern = [2, 2] // 점선 스타일

            graphView.layer.insertSublayer(verticalLineLayer, at: 0)
        }

        // 그래프 선을 그리는 레이어 추가
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.Purple500.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.fillColor = UIColor.clear.cgColor

        // 그래프 선 레이어를 맨 뒤에 추가
        graphView.layer.insertSublayer(shapeLayer, at: 0)
    }

    @objc private func periodButtonTapped(_ sender: UIButton) {
        // 버튼 스타일 업데이트
        for case let button as UIButton in sender.superview?.subviews ?? [] {
            button.setTitleColor(button == sender ? .White : .Gray600, for: .normal)
            button.backgroundColor = button == sender ? .Gray700 : .clear
        }

        // 데이터 업데이트 (예시: 버튼에 따라 데이터 변경 가능)
        switch sender.tag {
        case 0:
            priceData = [
                PriceData(price: 11500, date: "23.11.07"),
                PriceData(price: 11000, date: "23.11.12"),
                PriceData(price: 7000, date: "23.11.07"),
                PriceData(price: 13000, date: "23.11.28")
            ]
        case 1:
            priceData = [
                PriceData(price: 12000, date: "23.10.01"),
                PriceData(price: 11000, date: "23.10.15"),
                PriceData(price: 11500, date: "23.11.01"),
                PriceData(price: 13000, date: "23.11.28")
            ]
        case 2:
            priceData = [
                PriceData(price: 10000, date: "23.08.01"),
                PriceData(price: 11000, date: "23.09.01"),
                PriceData(price: 11500, date: "23.10.01"),
                PriceData(price: 12000, date: "23.11.01"),
                PriceData(price: 13000, date: "23.11.28")
            ]
        default:
            break
        }

        drawGraph()
    }
}
