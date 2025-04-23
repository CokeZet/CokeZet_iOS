//
//  UIView+Extension.swift
//  CokeZet-Components
//
//  Created by 김진우 on 3/21/25.
//

import UIKit

public extension UIViewController {
    /// 팝업을 호출하는 함수
    func showPopup(_ loginFlag: Bool,
                   _ leftButtonAction: UIAction?,
                   _ rightButtonAction: UIAction?) -> UIView {
        // PopupView 인스턴스 생성
        let state = PopupView.State(loginFlag: loginFlag, leftButtonAction: leftButtonAction, rightButtonAction: rightButtonAction)
        let popupView = PopupView(state)
        
        // 팝업 설정
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        
        // 팝업 레이아웃 설정
        
        popupView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 팝업 애니메이션 추가
        popupView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            popupView.alpha = 1
        }
        
        return popupView
    }
    
    /// 팝업을 닫는 함수
    func dismissPopup() {
        // 팝업 뷰를 찾아서 제거
        for subview in view.subviews {
            if let popupView = subview as? PopupView {
                UIView.animate(withDuration: 0.3, animations: {
                    popupView.alpha = 0
                }, completion: { _ in
                    popupView.removeFromSuperview()
                })
            }
        }
    }
}
