//
//  GuestView.swift
//  Main-Feature
//
//  Created by 김진우 on 5/9/25.
//

import UIKit

class GuestView: UIView {
    // Dim 처리를 위한 오버레이 뷰
    private let dimmingOverlayView: UIView = {
        let view = UIView()
        return view
    }()
    
    // "회원가입 하고 잠금 풀기" 버튼
    private let unlockButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입 하고 잠금 풀기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemRed // 밝은 빨간색
        button.layer.cornerRadius = 22 // 버튼 높이의 절반 정도로 하여 완전히 둥글게 만듭니다.
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        // 버튼 내부 컨텐츠에 대한 패딩 설정
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 25, bottom: 12, right: 25)
        // 그림자 효과 (선택 사항)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.3
        return button
    }()
    
    private let gradientLayer = CAGradientLayer()
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 뷰의 크기가 변경될 때마다 그라디언트 레이어의 프레임도 업데이트
        gradientLayer.frame = dimmingOverlayView.bounds
    }
    
    // MARK: - UI Setup
    
    private func setupViews() {
        addSubview(dimmingOverlayView)
        addSubview(unlockButton)
        dimmingOverlayView.layer.addSublayer(gradientLayer)
    }
    
    private func setupLayout() {
        dimmingOverlayView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        unlockButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupGradient() {
        // 그라디언트 색상 설정
        let startColor = UIColor(hex: "#1E1E1E", alpha: 0.4)?.cgColor // 상단: 1E1E1E, 40% 투명도
        let endColor = UIColor(hex: "#1E1E1E", alpha: 1.0)?.cgColor   // 하단: 1E1E1E, 100% 투명도

        gradientLayer.colors = [startColor, endColor]

        // 그라디언트 방향 설정 (위에서 아래로)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0) // y=0 (상단)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)   // y=1 (하단)

        // 초기 프레임 설정 (layoutSubviews에서 최종 크기 조정)
        gradientLayer.frame = dimmingOverlayView.bounds
    }
    
    // MARK: - Public Methods
    
    /// 버튼에 액션을 추가하는 메서드
    /// - Parameters:
    ///   - target: 액션을 수신할 객체
    ///   - action: 실행될 selector
    public func setUnlockAction(target: Any?, action: Selector) {
        unlockButton.addTarget(target, action: action, for: .touchUpInside)
    }
}
