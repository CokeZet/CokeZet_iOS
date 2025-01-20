//
//  Network.swift
//  Manifests
//
//  Created by 김진우 on 1/15/25.
//

import Foundation
import Combine

public struct Network {
    
    public init() {}
    
    public func Example() async {
        print("Network Hello")
        
        let endpoint = Endpoint.example
        
        do {
            let post: [Post] = try await NetworkService.shared.requestAsync(endpoint: endpoint)
            print(post)
        } catch {
            print("Error: \(error)")
        }
    }
}
