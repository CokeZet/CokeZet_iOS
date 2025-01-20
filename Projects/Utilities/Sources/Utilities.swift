//
//  Utilities.swift
//  Manifests
//
//  Created by 김진우 on 1/15/25.
//

public struct Utilities {
    public init() {}
}

public extension Int {
    public func testItem() -> String {
        if self % 2 == 1 {
            return "홀수"
        }
        return "짝수"
    }
}
