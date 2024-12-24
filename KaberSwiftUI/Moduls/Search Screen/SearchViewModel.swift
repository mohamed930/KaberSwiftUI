//
//  SearchViewModel.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 24/12/2024.
//

import SwiftUI
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    
    @Published var searchResults: [ArticleModel] = []
    
    @Published var isloading: Bool = false
    @Published var showMoreLoading: Bool = false
    @Published var page: Int = 1
    
    @Published var buttonTappedSearch: Bool = false
    
    private let api = NewsAPI()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupDebounce()
    }
    
    private func setupDebounce() {
        $searchText
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main) // Debounce for 1.0 seconds
        .removeDuplicates() // Optional: Avoid triggering for the same value
        .sink { [weak self] newText in
            guard let self = self else { return }
            
            if !newText.isEmpty && !buttonTappedSearch {
                print(newText)
                
                Task { @MainActor in
                    await self.fetchDataOnline(q: newText)
                }
            }
            
        }
        .store(in: &cancellables)
    }
    
    private func fetchDataOnline(q: String = "*",isShowMore: Bool = false) async {
        do {
            if isShowMore {
                showMoreLoading = true
            }
            else {
                isloading = true
            }
            
            let response = try await api.fetchAllArticles(q: q, page: page, language: api.getAppLanguage())
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.isloading = false
                self.showMoreLoading = false
                
                if self.searchResults.isEmpty || page == 1 {
                    self.searchResults = response.articles
                }
                else {
                    self.searchResults += response.articles
                }
                
                self.buttonTappedSearch = false
            }
            
        } catch {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.isloading = false
                self.showMoreLoading = false
            }
            
            print(error.localizedDescription)
        }
    }
    
    func sumbitSearch() async {
        if !searchText.isEmpty {
            buttonTappedSearch = true
            await fetchDataOnline(q: searchText, isShowMore: false)
        }
    }
    
    func showMore() async {
        page += 1
        await fetchDataOnline(q: searchText, isShowMore: true)
    }
    
}
