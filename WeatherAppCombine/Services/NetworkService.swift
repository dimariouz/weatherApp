//
//  NetworkService.swift
//  WeatherAppCombine
//
//  Created by Dmitry Doroshchuk on 26.02.2023.
//

import Combine
import Foundation

enum APIError: Error {
    case wrongURL
    
    var errorDescription: String {
        switch self {
        case .wrongURL:
            return "Wrong URL"
        }
    }
}

protocol NetworkServiceProtocol: AnyObject {
    func get<T: Decodable>(path: String, params: [String : String]) -> AnyPublisher<T, Error>
}

final class NetworkService: NetworkServiceProtocol {
    func get<T: Decodable>(path: String, params: [String : String]) -> AnyPublisher<T, Error> {
        guard let url = URL(string: Constants.APIs.host + path),
                let urlRequest = URLComponents(url: url, resolvingAgainstBaseURL: false)?.addParams(params).request else {
            return Fail(error: APIError.wrongURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

private extension URLComponents {
    func addParams(_ params: [String: String]) -> URLComponents {
        var copy = self
        copy.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        return copy
    }
    
    var request: URLRequest? {
        url.map { URLRequest.init(url: $0) }
    }
}
