//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Dmitry Doroshchuk on 17.08.2022.
//

import UIKit
import Alamofire

protocol NetworkServiceProtocol: AnyObject {
    func get<T: Codable>(path: String) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    let metricParams = ["units": "metric",
                        "appid": Constants.APIs.apiKey]
    private var session: Session!
  
    func get<T: Codable>(path: String) async throws -> T {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache?.removeAllCachedResponses()
        session = Session(configuration: configuration)
        return try await session.request(Constants.APIs.host + path,
                                         method: .get,
                                         parameters: metricParams).serializingDecodable(T.self).value
    }
}
