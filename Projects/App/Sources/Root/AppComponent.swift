//
//  AppComponent.swift
//  App
//
//  Created by 김진우 on 1/9/25.
//

import ModernRIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
