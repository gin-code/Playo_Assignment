//
//  DataModel.swift
//  playoAssignment
//
//  Created by Sparsh Singh on 04/07/22.
//

import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String
    let name: String
}
