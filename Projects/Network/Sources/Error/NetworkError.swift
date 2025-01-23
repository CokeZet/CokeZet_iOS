//
//  NetworkError.swift
//  CokeZet-Network
//
//  Created by 김진우 on 1/20/25.
//

public enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case decodingError(String)
    case serverError(statusCode: Int)
}

public extension NetworkError {
    var errorMessage: String {
        switch self {
        case .invalidUrl:
            return Errors.url
        case .invalidResponse:
            return Errors.response
        case .decodingError(let description):
            return Errors.decoding + description
        case .serverError(let statusCode):
            return Errors.server + String(statusCode)
        }
    }
}

private struct Errors {
    static let url = "유효하지 않은 URL입니다"
    static let response = "유효하지 않은 응답입니다"
    static let decoding = "디코딩 에러입니다: "
    static let server = "서버 에러입니다: "
}
