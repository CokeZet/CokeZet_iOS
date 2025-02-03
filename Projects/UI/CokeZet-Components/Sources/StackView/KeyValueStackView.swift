//
//  KeyValueStackView.swift
//  CokeZet-DesignSystem
//
//  Created by 김진우 on 2/3/25.
//

import UIKit

import SnapKit
import Then
import CokeZet_DesignSystem

/// ToolTip 컴포넌트 정의
/// figma: https://www.figma.com/design/2Sd5HIV4AVqvFUEzNpbBgX/SD%F0%9F%A5%A4?node-id=1245-10476&t=CXFXuqoYu6hHFjZ8-4
public final class KeyValueStackView: UIStackView {
    let keyLabel: UILabel = UILabel(frame: .zero).then {
        $0.textColor = ZetColor.Gray500.color
        $0.font = Typography.T14.font
    }
    
    let valueLabel: UILabel = UILabel(frame: .zero).then {
        $0.textColor = ZetColor.White.color
        $0.font = Typography.T14.font
    }
    
    let imageView: UIImageView = UIImageView(frame: .zero)

    public init() {
        super.init(frame: .zero)
        self.addConfigure()
        self.makeConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConfigure() {
        self.setContentHuggingPriority(.required, for: .horizontal)
        self.setContentCompressionResistancePriority(.required, for: .horizontal)
        self.axis = .horizontal
        self.alignment = .center
        [keyLabel, valueLabel].forEach {
            self.addArrangedSubview($0)
        }
    }

    private func makeConstraints() {
        keyLabel.snp.makeConstraints {
            $0.width.equalTo(68)
            $0.height.equalTo(30)
        }
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(36)
        }
    }
    
    public func setKeyValue(_ key: String, _ value: String, _ type: KeyValueType = .normal) -> KeyValueStackView {
        keyLabel.text = key
        var text = ""
        
        switch type {
        case .cardSale:
            // "카드사 가격"으로 가정
            var creditCardSale = value.components(separatedBy: " ")
            creditCardSale[1] = creditCardSale[1].replacingOccurrences(of: "원", with: "").formatWithComma()
            text = creditCardSale.joined(separator: " ") + "원"
        case .deliveryPrice:
            let deliveryPrice = value.replacingOccurrences(of: "원", with: "").formatWithComma()
            text = deliveryPrice + "원 별도"
        case .normal:
            let deliveryPrice = value.replacingOccurrences(of: "원", with: "").formatWithComma()
            text = deliveryPrice + "원"
        }
        
        valueLabel.text = text
        return self
    }
    
    public func setLargeValue() -> KeyValueStackView {
        let numberPart = valueLabel.text?.replacingOccurrences(of: "원", with: "") ?? "0"
        let formattedNumber = numberPart.formatWithComma()
        let unitPart = "원"

        let combinedText = "\(formattedNumber)\(unitPart)"

        // NSMutableAttributedString 생성
        let attributedString = NSMutableAttributedString(string: combinedText)

        // 숫자 부분에 fontSize: 24 적용
        let numberRange = (combinedText as NSString).range(of: formattedNumber)
        attributedString.addAttribute(.font,
                                      value: Typography.T24.font,
                                      range: numberRange)

        // "원" 부분에 fontSize: 14 적용
        let unitRange = (combinedText as NSString).range(of: unitPart)
        attributedString.addAttribute(.font,
                                      value: Typography.T16.font,
                                      range: unitRange)

        // "원"의 시작 위치를 계산
        let kernRange = NSRange(location: unitRange.location - 1, length: 1)
        // 숫자와 "원" 사이에만 2px 간격 추가
        attributedString.addAttribute(.kern,
                                      value: 2,
                                      range: kernRange)

        // 모든 텍스트에 빨간색 적용
        attributedString.addAttribute(.foregroundColor,
                                      value: ZetColor.Red500.color,
                                      range: NSRange(location: 0,
                                                     length: combinedText.count))
        
        valueLabel.attributedText = attributedString
        return self
    }
    
    public func setImage(_ image: UIImage) -> KeyValueStackView {
        valueLabel.removeFromSuperview()
        
        self.addArrangedSubview(imageView)
        
        imageView.image = image
        return self
    }
    
    public func addToolTip() -> KeyValueStackView {
        let emptyView = UIView()
        emptyView.snp.makeConstraints {
            $0.width.equalTo(4)
        }
        let toolTip = ToolTip()
        
        [emptyView, toolTip].forEach {
            self.addArrangedSubview($0)
        }
        
        return self
    }
}

@available(iOS 17.0, *)
#Preview(
    "button state",
    traits: .sizeThatFitsLayout
) {
    let contentView = UIStackView()
    contentView.axis = .vertical
    contentView.distribution = .fill
    contentView.alignment = .leading
    contentView.spacing = 4
    contentView.backgroundColor = ZetColor.Gray800.color
    
    let stackView = KeyValueStackView()
        .setKeyValue("최저가", "13000원")
        .setLargeValue()
    
    let stackView2 = KeyValueStackView()
        .setKeyValue("100ml", "193원")
    
    let stackView3 = KeyValueStackView()
        .setKeyValue("판매처", "")
        .setImage(CokeZetDesignSystemAsset.alertCircle.image)
    
    let stackView4 = KeyValueStackView()
        .setKeyValue("배송비", "3000원", .deliveryPrice)
    
    let stackView5 = KeyValueStackView()
        .setKeyValue("카드할인", "신한카드 12300원", .cardSale)
        .addToolTip()
    
    [stackView, stackView2, stackView3, stackView4, stackView5].forEach {
        contentView.addArrangedSubview($0)
    }

    return contentView
}
