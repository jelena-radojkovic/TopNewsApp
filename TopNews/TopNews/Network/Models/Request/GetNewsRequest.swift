//
//  GetNewsRequest.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 11.11.22..
//

import Foundation

struct GetNewsRequest: APIRequest {
    var endpoint: String = "/v2/top-headlines"
    var method: APIRequestMethod = .get
    var params: [URLQueryItem]?
    var body: Codable?
    
    init(params: [URLQueryItem]) {
        self.params = params
    }
}
