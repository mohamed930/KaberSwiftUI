//
//  NewsComponets.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI

struct NewsComponets: View {
    
    @Binding var articleModel: ArticleModel
    
    var buttonTapped: () -> ()
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 8) {
            
            HStack {
                Spacer()
                
                CustomAsyncImage(img: articleModel.urlToImage ?? "") { img in
                    img
                        .resizable()
                        .clipShape(.rect(cornerRadius: 10))
                        .scaledToFit()
                        .frame(height: 183)
                        
                }
                
                Spacer()
            }
            
            
            Text(articleModel.title)
                .setFont(fontName: .bold, size: 20)
                .lineLimit(1)
            
            HStack {
                Image(.newsAuthor)
                
                Text(articleModel.author ?? "Unkown")
                    .setFont(fontName: .semiBold, size: 13)
                    .foregroundStyle(Color("#4E4B66"))
                
                Image(systemName: "clock")
                    .frame(width: 14,height: 14)
                    .foregroundStyle(Color("#4E4B66"))
                
                Text(articleModel.publishedAt)
                    .setFont(fontName: .regular, size: 13)
                    .foregroundStyle(Color("#4E4B66"))
            }
            
            Text(articleModel.description ?? "")
                .setFont(fontName: .medium, size: 16)
                .foregroundStyle(Color("#4E4B66"))
                .padding(.bottom,10)
            
            CustomButton(buttonTitle: "Read More") {
                buttonTapped()
            }
        }
        
    }
}

#Preview {
    @State var article = ArticleModel(connection: false,
                                      source: SourceModel(id: "1", name: ""),
                                      author: "",
                                      title: "",
                                      description: "",
                                      url: "",
                                      urlToImage: "",
                                      urlToImageData: Data(),
                                      publishedAt: "",
                                      content: "")
    return NewsComponets(articleModel: $article) {  }
}
