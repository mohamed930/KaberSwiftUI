//
//  CustomAsyncImage.swift
//  CaptainWee
//
//  Created by Mohamed Ali on 03/08/2024.
//

import SwiftUI

struct CustomAsyncImage<Content: View>: View {
    let img: String
    var errorImageSize: CGFloat = 183
    let content: (Image) -> Content
    
    init(img: String,errorImageSize: CGFloat = 183, @ViewBuilder content: @escaping (Image) -> Content) {
        self.img = img
        self.errorImageSize = errorImageSize
        self.content = content
    }
    
    var body: some View {
        AsyncImage(url: URL(string: img)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 30, height: 30)
            case .success(let image):
                content(image)
            case .failure:
                Image(.newsImages)
                    .resizable()
                    .scaledToFit()
                    .frame(width: errorImageSize)
            @unknown default:
                EmptyView()
            }
        }
//        .frame(width: 50,height: 50)
    }
}

#Preview {
    CustomAsyncImage(img: "https://cwq.lnj.sa/onboardingimage?token=db82c40444b3855377f1cca6ab5c0dcb&onboardingid=1") { _ in }
}
