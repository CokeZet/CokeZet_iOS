//
//  NavigationStreamState.swift
//  CokeZet-App
//
//  Created by 김진우 on 3/21/25.
//

import Combine
import Foundation

// 공유할 스트림을 정의합니다
public protocol NavgiationBarActions {
    var stream: CurrentValueSubject<NavigationActions, Never> { get }
    func send(_ action: NavigationActions)
}

public class NavigationStreamState: NavgiationBarActions {
    private let actionSubject = CurrentValueSubject<NavigationActions, Never>(.none)
    
    public init() {}
    
    public var stream: CurrentValueSubject<NavigationActions, Never> {
        return actionSubject
    }
    
    public func send(_ action: NavigationActions) {
        actionSubject.send(action)
    }
}

public enum NavigationActions {
    case home
    case alarm
    case setting
    case back
    case none
}
