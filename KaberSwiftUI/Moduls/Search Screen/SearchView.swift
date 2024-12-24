//
//  SearchView.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 24/12/2024.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewmodel = SearchViewModel()
    @EnvironmentObject var navigationManager: NavigationPathManager
    
    var body: some View {
        
        ZStack {
            Color(.backgroundScreen)
                .ignoresSafeArea(.all)
            
            VStack {
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color(.searchTextField)) // Magnifying glass color
                        .padding(.leading, 16)
                    
                    TextField("", text: $viewmodel.searchText,prompt: Text("Search")
                        .foregroundColor(Color(.searchTextField)))
                    .setFont(fontName: .regular, size: 14)
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            await viewmodel.sumbitSearch()
                        }
                    }
                    .frame(height: 46)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("#4E4B66"), lineWidth: 1) // Border
                )
                
                Group {
                    if viewmodel.isloading {
                        VStack {
                            Spacer()
                            
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(width: 60,height: 50)
                            
                            Spacer()
                            
                        }
                    }
                    else {
                        if viewmodel.searchText.isEmpty || viewmodel.searchResults.isEmpty {
                            VStack {
                                Spacer()
                                
                                Text("No results")
                                    .foregroundColor(Color(.searchTextField))
                                    .setFont(fontName: .regular, size: 16)
                                    .padding(.vertical, 16)
                                
                                Spacer()
                                
                            }
                        }
                        else {
                            ScrollView {
                                LazyVStack(spacing: 16) {
                                    ForEach(viewmodel.searchResults.indices, id: \.self) { index in
                                        
                                        SeearchResultComponets(model: $viewmodel.searchResults[index])
                                        .onTapGesture {
                                            navigationManager.path.append(viewmodel.searchResults[index])
                                        }
                                        .onAppear {
                                            if index == viewmodel.searchResults.count - 1 {
                                                print("Reached the last element")
                                                Task {
                                                    await viewmodel.showMore()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .scrollDismissesKeyboard(.immediately)
                            
                            LoadingComponents(isloading: $viewmodel.showMoreLoading)
                        }
                        
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 20)
            .navigationDestination(for: ArticleModel.self) { article in
                KaberNewsDetailsView(viewmodel: KaberNewsDetailsViewModel(article: article))
            }
        }
        
        
    }
}

#Preview {
    // Provide a mock NavigationPathManager
    let navigationManager = NavigationPathManager()
    
    SearchView()
        .environmentObject(navigationManager)
}
