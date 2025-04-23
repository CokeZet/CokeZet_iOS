//
//  NetworkService.swift
//  CokeZet-Network
//
//  Created by 김진우 on 1/20/25.
//

import Foundation
import Combine

public struct NetworkService: NetworkProtocol {
    
    public let session: URLSessionProtocol
    
    public static let shared: NetworkService = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return NetworkService(session: session)
    }()
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    public func requestAsync<T: Decodable>(endpoint: EndpointProtocol) async throws -> T {
        guard let url = configUrl(endpoint: endpoint) else {
            throw NetworkError.invalidUrl
        }
        
        let request = configRequest(url: url, endpoint: endpoint)
        let (data, response) = try await session.data(for: request)
        
        return try processResponse(data: data, response: response)
    }
    
    public func requestPublisher<T>(endpoint: Endpoint) -> AnyPublisher<T, Error> where T: Decodable {
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
        
        let defaultHeader = ["Content-Type": "application/json", "accept": "application/json"]
        
        for (key, value) in defaultHeader {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let headers = endpoint.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        logFullRequest(request)
        return request
    }
    
    private func processResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        logFullResponse(data: data, response: response)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            // 에러 응답 본문 디코딩 시도
            if let errorResponse = try? decoder.decode(AuthResponse<Int>.self, from: data) {
                // ** 401이고 AUTH-003이면 토큰 만료 에러 throw **
                if httpResponse.statusCode == 401 && errorResponse.code == "AUTH-003" {
                    print(">>> NetworkService: Detected Token Expiry (AUTH-003)")
                    throw NetworkError.tokenExpired(statusCode: httpResponse.statusCode) // 특정 에러 throw
                }
                // 다른 API 레벨 에러
                print(">>> NetworkService: Detected API Error: \(errorResponse.code) - \(errorResponse.message)")
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            } else {
                // 에러 본문 디코딩 실패 또는 다른 형식
                throw NetworkError.decodingError("NetworkService: Failed to decode API error response body or non-JSON error.")
            }
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error.localizedDescription)
        }
    }
    private func logFullRequest(_ request: URLRequest) {
        print("\n==== 📤 REQUEST ====")
        print("URL: \(request.url?.absoluteString ?? "nil")")
        print("METHOD: \(request.httpMethod ?? "nil")")
        print("HEADERS: \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("BODY: \(bodyString)")
        } else {
            print("BODY: nil or not UTF-8")
        }
        print("==== END REQUEST ====\n")
    }
    
    private func logFullResponse(data: Data, response: URLResponse) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        print("\n==== 📥 RESPONSE ====")
        print("URL: \(httpResponse.url?.absoluteString ?? "nil")")
        print("STATUS: \(httpResponse.statusCode)")
        print("HEADERS: \(httpResponse.allHeaderFields)")
        if let responseString = String(data: data, encoding: .utf8) {
            print("BODY: \(responseString)")
        } else {
            print("BODY: nil or not UTF-8")
        }
        print("==== END RESPONSE ====\n")
    }
    
}
