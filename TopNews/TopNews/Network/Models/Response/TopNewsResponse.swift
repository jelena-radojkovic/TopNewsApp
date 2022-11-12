//
//  TopNewsResponse.swift
//  TopNews
//
//  Created by Jelena Radojkovic on 11.11.22..
//

import Foundation

struct Source: Codable {
    let id: String?
    let name: String
}

struct TopNewsResponse: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}
