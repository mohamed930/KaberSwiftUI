//
//  ArticleModel.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import Foundation

// MARK: - Article
struct ArticleModel: Codable, Hashable {
    let connection: Bool?
    let source: SourceModel
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let urlToImageData: Data?
    let publishedAt: String
    let content: String
}

// MARK: - Source
struct SourceModel: Codable, Hashable {
    let id: String?
    let name: String
}
