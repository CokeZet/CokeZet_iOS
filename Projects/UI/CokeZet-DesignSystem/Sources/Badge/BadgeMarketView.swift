//
//  BadgeMarketView.swift
//  CokeZet-DesignSystem
//
//  Created by Daye on 2/12/25.
//

import UIKit

import SnapKit

public final class BadgeMarketView: UIView {

    

    public init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBlue
        layer.cornerRadius = 8
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
