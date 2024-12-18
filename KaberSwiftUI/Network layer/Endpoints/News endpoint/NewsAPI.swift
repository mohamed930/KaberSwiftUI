//
//  NewsAPI.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 18/12/2024.
//

import Foundation

protocol NewsProtocol {
    func fetchAllArticles(q: String,page: Int,language: String) async throws -> Response<[ArticleModel]>
}

class NewsAPI: BaseAPI<NewsNetworking>, NewsProtocol {
    
    func fetchAllArticles(q: String, page: Int, language: String) async throws -> Response<[ArticleModel]> {
        try await fetchData(Target: .fetchAllNews(q: q, language: language, page: page))
    }
    
    
}
