//
//  NSObject+Extension.swift
//  CokeZet-Utilities
//
//  Created by 김진우 on 2/24/25.
//

import ObjectiveC

extension NSObject {
    /// 타입명을 문자열 형태로 반환합니다. (보통 재사용 식별자로 사용됨)
    public class var identifier: String {
        return String(describing: self)
    }
}
