//
//  KaberNewsViewModel.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI

class KaberNewsViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    
    @Published var newsItems = Array(1...10)
    
    func selectElement(index: Int) -> ArticleModel {
        var selectedElement = ArticleModel(connection: false,
                                source: SourceModel(id: "1", name: ""),
                                author: "",
                                title: "",
                                description: "",
                                url: "",
                                urlToImage: "",
                                urlToImageData: Data(),
                                publishedAt: "",
                                content: "")
        
        return selectedElement
    }
}
