//
//  ContentView.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI
import BetterSafariView

struct KaberNewsView: View {
    
    @StateObject var viewmodel = KaberNewsViewModel()
    @EnvironmentObject var navigationManager: NavigationPathManager
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            ZStack {
                
                Color(.backgroundScreen)
                    .ignoresSafeArea(.all)
                
                VStack {
                    Text("News")
                        .setFont(fontName: .bold, size: 20)
                    
                    ZStack {
                        
                        VStack(spacing: 26) {
                            HStack {
                                Image(.kaberLogo)
                                Spacer()
                            }
                            
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color(.searchTextField)) // Magnifying glass color
                                    .padding(.leading, 16)
                                
                                TextField("", text: $viewmodel.searchText,prompt: Text("Search")
                                    .foregroundColor(Color(.searchTextField)))
                                    .setFont(fontName: .regular, size: 14)
                                    .frame(height: 46)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("#4E4B66"), lineWidth: 1) // Border styling
                            )
                            .frame(height: 40) // Adjust the height
                            
                            ScrollView {
                                LazyVStack(spacing: 16) {
                                    ForEach(viewmodel.newsItems.indices, id: \.self) { index in
                                        
                                        NewsComponets(articleModel: $viewmodel.newsItems[index]) {
                                            
                                            viewmodel.returnUrl(selectedIndex: index)
                                            
                                        }
                                        .onTapGesture {
                                            let selected = viewmodel.selectElement(index: index)
                                            navigationManager.path.append(selected)
                                        }
                                        .onAppear {
                                            if index == viewmodel.newsItems.count - 1 {
                                                print("Reached the last element")
                                                Task {
                                                    await viewmodel.fetchMoreData()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .scrollDismissesKeyboard(.immediately)
                            
                            LoadingComponents(isloading: $viewmodel.showMoreLoading)
                            
                        }
                        
                        VStack {
                            Spacer()
                            
                            ErrorView(showError: $viewmodel.showConnectionError)
                        }
                        .padding(.bottom,20)
                        
                    }
                    
                    
                    Spacer()
                }
                .padding(.vertical)
                .padding(.horizontal,20)
                .handleLoading(isLoading: $viewmodel.isloading)
                .onAppear {
                    Task { @MainActor in
                        if !viewmodel.dataFetched {
                            await viewmodel.fetchData()
                        }
                    }
                }
                .navigationDestination(for: ArticleModel.self) { article in
                    KaberNewsDetailsView(viewmodel: KaberNewsDetailsViewModel(article: article))
                }
                .safariView(isPresented: $viewmodel.showSafari) {
                    SafariView(
                        url: viewmodel.selectedUrl!,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: false,
                            barCollapsingEnabled: true
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    // Provide a mock NavigationPathManager
    let navigationManager = NavigationPathManager()
    
    return KaberNewsView()
        .environmentObject(navigationManager) // Inject environment object
}
