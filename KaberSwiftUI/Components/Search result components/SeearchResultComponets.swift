//
//  SeearchResultComponets.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 24/12/2024.
//

import SwiftUI

struct SeearchResultComponets: View {
    
    @Binding var model: ArticleModel
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 12) {
            // Left Image
            CustomAsyncImage(img: model.urlToImage ?? "",errorImageSize: 100) { img in
                img
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .clipped()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                // Category
                Text(model.source.name)
                    .setFont(fontName: .regular, size: 14)
                    .foregroundColor(.gray)
                
                // Title
                Text(model.title)
                    .setFont(fontName: .medium, size: 16)
                    .lineLimit(2)
                
                HStack(spacing: 6) {
                    // News Source
                    Image(.newsAuthor) // Replace with your logo name
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                    
                    Text(model.source.name)
                        .setFont(fontName: .regular, size: 13)
                        .foregroundColor(.gray)
                    
                    Image(systemName: "clock")
                        .frame(width: 14,height: 14)
                        .foregroundStyle(Color("#4E4B66"))
                    
                    // Time
                    Text(model.publishedAt)
                        .setFont(fontName: .regular, size: 13)
                        .lineLimit(1)
                        .foregroundColor(.gray)
                }
            }
            
            Image(.arrowRight)
                .padding(.trailing,-40)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.backgroundScreen))
        )
        
    }
}

#Preview {
    @State var model: ArticleModel = ArticleModel(
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
    )
    SeearchResultComponets(model: $model)
}
