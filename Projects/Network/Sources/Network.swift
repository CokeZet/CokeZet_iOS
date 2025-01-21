//
//  Network.swift
//  Manifests
//
//  Created by 김진우 on 1/15/25.
//

import Foundation
import Combine

public struct Network {
    public static let shared = Network()
    
    public init() {}
    
    var test: AnyPublisher<[Post], Error>?
    var cancellables = Set<AnyCancellable>()
    
    public func Example() async -> Result<[Post], Error> {
        print("Network Hello")
        
        let endpoint = Endpoint.example
        
        do {
            let post: [Post] = try await NetworkService.shared.requestAsync(endpoint: endpoint)
            return .success(post)
        } catch {
            print("Error: \(error)")
            return .failure(error)
        }
    }
    
    public mutating func ExampleCombine(){
        let endpoint = Endpoint.example
        
        test = NetworkService.shared.requestPublisher(endpoint: endpoint)
        
        test?.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Request completed successfully.")
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }, receiveValue: { posts in
            print("Received posts: \(posts)")
        })
        .store(in: &cancellables)
    }
    
    
}
