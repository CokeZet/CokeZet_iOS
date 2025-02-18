//
//  ProductInfomationCell.swift
//  ProductDetail-Feature
//
//  Created by 김진우 on 2/14/25.
//

import UIKit
import CokeZet_DesignSystem

public final class ProductInfomationCell: UICollectionViewCell {
    
    let titleLabel: ZetLabel = ZetLabel(typography: .T18, textColor: .White)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        makeConstraints()
        addConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
    }
    
    private func makeConstraints() {
        
    }
    
    private func addConfigure() {
        
    }
}
