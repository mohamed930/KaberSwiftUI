//
//  KaberNewsDetailsView.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI
import BetterSafariView

struct KaberNewsDetailsView: View {
    
    @ObservedObject var viewmodel: KaberNewsDetailsViewModel
    @EnvironmentObject var navigationManager: NavigationPathManager
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading,spacing: 16) {
                
                HStack {
                    Image(.newsAuthor)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    
                    VStack(alignment: .leading) {
                        Text(viewmodel.article.author ?? "unkown")
                            .setFont(fontName: .semiBold, size: 16)
                        
                        Text(viewmodel.article.publishedAt)
                            .setFont(fontName: .semiBold, size: 14)
                            .foregroundStyle(Color("#4E4B66"))
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal,10)
                
                
                CustomAsyncImage(img: viewmodel.article.urlToImage ?? "") { img in
                    img
                        .resizable()
                        .scaledToFill()
                        .frame(width: 380,height: 248)
                        .clipShape(.rect(cornerRadii: .init(topLeading: 6, bottomLeading: 6, bottomTrailing: 6, topTrailing: 6)))
                }
                    
                
                Text(viewmodel.article.title)
                    .padding(.leading,6)
                    .setFont(fontName: .regular, size: 24)
                
                
                Text(viewmodel.article.content)
                    .padding(.leading,6)
                    .setFont(fontName: .regular, size: 16)
                    .foregroundStyle(Color("#4E4B66"))
                    .padding(.bottom,30)
                
                CustomButton(buttonTitle: "Read More") {
                    viewmodel.showSafari = true
                }
                
                Spacer()
            }
            .padding(.vertical)
            .padding(.horizontal,20)
        }
        .padding(.vertical,10)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewmodel.shareContent()
                }) {
                    Image(.share)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                }
                .frame(width: 50,height: 50)
            }
        }
        .safariView(isPresented: $viewmodel.showSafari) {
            SafariView(
                url: URL(string: viewmodel.article.url)!,
                configuration: SafariView.Configuration(
                    entersReaderIfAvailable: false,
                    barCollapsingEnabled: true
                )
            )
        }
        
    }
}

#Preview {
    KaberNewsDetailsView(viewmodel: KaberNewsDetailsViewModel(article: ArticleModel(
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
    )))
}
