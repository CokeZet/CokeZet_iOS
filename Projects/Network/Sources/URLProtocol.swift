//
//  URLProtocol.swift
//  CokeZet-Network
//
//  Created by 김진우 on 1/16/25.
//
import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }

protocol NetworkProtocol {
    var session: URLSessionProtocol { get }
    func request<T: Decodable>(endpoint: EndpointProtocol) async throws -> T
}

protocol EndpointProtocol {
    var baseURL: URL? { get }
    var path: String { get }
    var method: NetworkMethod { get }
    var parameters: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Encodable? { get }
}
