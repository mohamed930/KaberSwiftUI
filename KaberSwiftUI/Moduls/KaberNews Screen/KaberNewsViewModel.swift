//
//  KaberNewsViewModel.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI

@MainActor
class KaberNewsViewModel: ObservableObject {
    
    private let api = NewsAPI()
    private let page: Int = 1
    
    @Published var searchText: String = ""
    
    @Published var isloading: Bool = false
    @Published var dataFetched: Bool = false
    @Published var newsItems: [ArticleModel] = []
    @Published var selectedUrl: URL?
    @Published var showSafari: Bool = false
    
    func fetchData(q: String = "*") async {
        do {
            isloading = true
            let response = try await api.fetchAllArticles(q: q, page: page, language: "en")
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.isloading = false
                self.newsItems = response.articles
                self.dataFetched = true
            }
            
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.isloading = false
            }
            
            print(error.localizedDescription)
        }
    }
    
    func selectElement(index: Int) -> ArticleModel {
        let selectedElement = newsItems[index]
        
        return selectedElement
    }
    
    func returnUrl(selectedIndex: Int){
        selectedUrl = URL(string: newsItems[selectedIndex].url)
        showSafari = true
    }
}


extension Array where Element == ArticleModel {
    static let mockArticles: [ArticleModel] = [
        ArticleModel(
            connection: true,
            source: SourceModel(id: "techcrunch", name: "TechCrunch"),
            author: "John Doe",
            title: "SwiftUI for Beginners: A Comprehensive Guide",
            description: "Learn how to build stunning iOS applications with SwiftUI in this beginner-friendly guide.",
            url: "https://techcrunch.com/swiftui-beginners-guide",
            urlToImage: "https://i.imgur.com/6YHcXoE.jpg",
            urlToImageData: nil,
            publishedAt: "2024-12-18T10:30:00Z",
            content: "SwiftUI is a modern framework by Apple for building user interfaces..."
        ),
        ArticleModel(
            connection: false,
            source: SourceModel(id: "theverge", name: "The Verge"),
            author: "Jane Smith",
            title: "The Future of AI in Mobile Apps",
            description: "Exploring the possibilities and challenges of integrating AI into mobile applications.",
            url: "https://theverge.com/future-of-ai-mobile-apps",
            urlToImage: "https://i.imgur.com/Q8tHkFj.jpg",
            urlToImageData: nil,
            publishedAt: "2024-12-17T08:15:00Z",
            content: "AI is revolutionizing the mobile app industry by offering advanced features..."
        ),
        ArticleModel(
            connection: true,
            source: SourceModel(id: "wired", name: "Wired"),
            author: nil,
            title: "The Rise of Quantum Computing",
            description: "Quantum computing is set to change the world of technology as we know it.",
            url: "https://wired.com/quantum-computing-rise",
            urlToImage: "https://example.com/images/quantum-computing.jpg",
            urlToImageData: nil,
            publishedAt: "2024-12-16T12:45:00Z",
            content: "Quantum computers use the principles of quantum mechanics to process information..."
        )
    ]
}
