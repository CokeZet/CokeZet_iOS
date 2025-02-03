//
//  ProductOverView.swift
//  CokeZet-UI
//
//  Created by 김진우 on 1/22/25.
//

import UIKit

import CokeZet_DesignSystem

import SnapKit
import Then
import CokeZet_Components
import SwiftUI

public class ProductOverCell: UICollectionViewCell {
    let infomationView = ProductInfomationView(frame: .zero)
    
    let buyButton = ZetRoundButton(buttonState: .Primary).then {
        $0.setTitle("최저가로 구매하기", for: .normal)
        
        let action = UIAction(handler: { _ in
            print("ProductOverView Buy Button clicked!")
        })
        
        $0.addAction(action, for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func initLayout() {
        [infomationView, buyButton].forEach {
            self.addSubview($0)
        }
        
        infomationView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        buyButton.snp.makeConstraints {
            $0.top.equalTo(infomationView.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview()
        }
    }
}

struct ProductOverCellPreview: UIViewRepresentable {
    func makeUIView(context: Context) -> ProductOverCell {
        let cell = ProductOverCell()
        cell.backgroundColor = ZetColor.Gray800.color
        return cell
    }

    func updateUIView(_ uiView: ProductOverCell, context: Context) {}
}

@available(iOS 17.0, *)
#Preview {
    ProductOverCellPreview()
        .frame(width: 360, height: 534)
}
