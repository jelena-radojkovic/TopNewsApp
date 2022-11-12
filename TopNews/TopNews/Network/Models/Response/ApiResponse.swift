//
//  ApiResponse.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 11.11.22..
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let status: String
    let totalResults: Int
    let articles: T
}
