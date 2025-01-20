//
//  URLProtocol.swift
//  CokeZet-Network
//
//  Created by 김진우 on 1/16/25.
//

import Foundation
import Combine

public protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        // URLSession의 기본 제공 메서드 호출
        return try await self.data(for: request, delegate: nil)
    }
}

public protocol NetworkProtocol {
    var session: URLSessionProtocol { get }
    func requestAsync<T: Decodable>(endpoint: EndpointProtocol) async throws -> T
    func requestPublisher<T: Decodable>(endpoint: Endpoint) -> AnyPublisher<T, Error>
}

public protocol EndpointProtocol {
    var baseURL: URL? { get }
    var path: String { get }
    var method: NetworkMethod { get }
    var parameters: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
}

