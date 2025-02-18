//
//  ToolTip.swift
//  CokeZet-DesignSystem
//
//  Created by 김진우 on 1/30/25.
//

import UIKit

import SnapKit
import CokeZet_DesignSystem

/// ToolTip 컴포넌트 정의
/// figma: https://www.figma.com/design/2Sd5HIV4AVqvFUEzNpbBgX/SD%F0%9F%A5%A4?node-id=557-14171&t=AJTf2WXskCeRDQuP-4
public final class ToolTip: UIView {
    let stackView: UIStackView = UIStackView(frame: .zero)
    let label: ZetLabel = ZetLabel(typography: .semiBold(.T14), textColor: .Purple500)
    let imageView: UIImageView = UIImageView(frame: .zero)
    
    private enum Metric {
        static let width: CGFloat = 89
        static let height: CGFloat = 32
        static let cornerRadius: CGFloat = height/2
        static let alertImage: UIImage = CokeZetDesignSystemAsset.alertCircle.image
    }

    public init() {
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setText(_ st: String) -> ToolTip {
        label.text = st
        return self
    }

    private func addConfigure() {
        self.addSubview(stackView)
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.layer.cornerRadius = Metric.cornerRadius
        imageView.image = Metric.alertImage
        
        [imageView, label].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.spacing = 4
        self.backgroundColor = ZetColor.Purple800.color.withAlphaComponent(0.15)
        label.text = "조건있음"
    }

    private func makeConstraints() {
        self.snp.makeConstraints {
            $0.width.equalTo(Metric.width)
            $0.height.equalTo(Metric.height)
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}

@available(iOS 17.0, *)
#Preview(
    "button state",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    contentView.alignment = .center
    contentView.spacing = 10
    contentView.backgroundColor = ZetColor.Gray800.color
    
    let tool = ToolTip()
    contentView.addArrangedSubview(tool)

    return contentView
}
