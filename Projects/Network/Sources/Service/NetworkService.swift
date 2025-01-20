//
//  NetworkService.swift
//  CokeZet-Network
//
//  Created by 김진우 on 1/20/25.
//

import Foundation
import Combine

struct NetworkService: NetworkProtocol {
    
    let session: URLSessionProtocol
    
    static let shared: NetworkService = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return NetworkService(session: session)
    }()
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func requestAsync<T: Decodable>(endpoint: EndpointProtocol) async throws -> T {
        guard let url = configUrl(endpoint: endpoint) else {
            throw NetworkError.invalidUrl
        }
        
        let request = configRequest(url: url, endpoint: endpoint)
        let (data, response) = try await session.data(for: request)
        
        return try processResponse(data: data, response: response)
    }
    
    func requestPublisher<T>(endpoint: Endpoint) -> AnyPublisher<T, Error> where T: Decodable {
        guard let url = configUrl(endpoint: endpoint) else {
            return Fail(error: NetworkError.invalidUrl)
                .eraseToAnyPublisher()
        }
        
        let request = configRequest(url: url, endpoint: endpoint)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension NetworkService {
    private func configUrl(endpoint: EndpointProtocol) -> URL? {
        guard let url = endpoint.baseURL?.appendingPathComponent(endpoint.path) else {
            return nil
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        components.queryItems = endpoint.parameters
        
        return components.url
    }
    
    private func configRequest(url: URL, endpoint: EndpointProtocol) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        return request
    }
    
    private func processResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error.localizedDescription)
        }
    }
}
