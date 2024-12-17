//
//  NewsComponets.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI

struct NewsComponets: View {
    
    var buttonTapped: () -> ()
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 8) {
            
            HStack {
                Spacer()
                Image(.newsImages)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 183)
                    .clipShape(.rect(cornerRadii: .init(topLeading: 6, bottomLeading: 6, bottomTrailing: 6, topTrailing: 6)))
                Spacer()
            }
            
            
            Text("Russian warship: Moskva sinks in Black Sea")
                .setFont(fontName: .bold, size: 20)
                .lineLimit(1)
            
            HStack {
                Image(.newsAuthor)
                
                Text("BBC News")
                    .setFont(fontName: .semiBold, size: 13)
                    .foregroundStyle(Color("#4E4B66"))
                
                Image(systemName: "clock")
                    .frame(width: 14,height: 14)
                    .foregroundStyle(Color("#4E4B66"))
                
                Text("4h ago")
                    .setFont(fontName: .regular, size: 13)
                    .foregroundStyle(Color("#4E4B66"))
            }
            
            Text("Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of \"earning their money in other people's blood\"")
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
    NewsComponets {  }
}
