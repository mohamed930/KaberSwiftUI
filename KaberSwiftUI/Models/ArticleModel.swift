//
//  ArticleModel.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import Foundation

// MARK: - Article
struct ArticleModel: Codable, Hashable, Storeable {
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
    
    init(connection: Bool?, source: SourceModel, author: String?, title: String, description: String?, url: String, urlToImage: String?, urlToImageData: Data?, publishedAt: String, content: String) {
        self.connection = connection
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.urlToImageData = urlToImageData
        self.publishedAt = publishedAt
        self.content = content
    }
    
    // Conform to `Storeable`
    var storeData: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(storeData: Data?) {
        guard let data = storeData,
              let decoded = try? JSONDecoder().decode(ArticleModel.self, from: data) else { return nil }
        self = decoded
    }
}

// MARK: - Source
struct SourceModel: Codable, Hashable, Storeable {
    let id: String?
    let name: String
    
    init(id: String?, name: String) {
        self.id = id
        self.name = name
    }
    
    // Conform to `Storeable`
    var storeData: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(storeData: Data?) {
        guard let data = storeData,
              let decoded = try? JSONDecoder().decode(SourceModel.self, from: data) else { return nil }
        self = decoded
    }
}

extension Array: Storeable where Element: Codable {
    var storeData: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(storeData: Data?) {
        guard let data = storeData,
              let decoded = try? JSONDecoder().decode([Element].self, from: data) else { return nil }
        self = decoded
    }
}
