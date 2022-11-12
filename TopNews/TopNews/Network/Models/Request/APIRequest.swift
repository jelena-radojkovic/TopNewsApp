//
//  APIRequest.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 11.11.22..
//

import Foundation

enum APIRequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

protocol APIRequest {
    var endpoint: String { get }
    var method: APIRequestMethod { get }
    var urlRequest: URLRequest? { get }
    var params: [URLQueryItem]? { get }
    var body: Codable? { get }
}

extension APIRequest {
    var urlRequest: URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = endpoint
        urlComponents.queryItems = params
        
        guard let urlComponent = urlComponents.url else { return nil }
        guard let url = URL(string: urlComponent.absoluteString) else { return nil}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let body = body as? Data {
            urlRequest.httpBody = body
        }
        
        return urlRequest
    }
}
