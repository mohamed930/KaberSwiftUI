//
//  KaberNewsDetailsView.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI

struct KaberNewsDetailsView: View {
    
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
                        Text("BBC News")
                            .setFont(fontName: .semiBold, size: 16)
                        
                        Text("14m ago")
                            .setFont(fontName: .semiBold, size: 14)
                            .foregroundStyle(Color("#4E4B66"))
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal,10)
                
                
                Image(.newsImages)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 380,height: 248)
                    .clipShape(.rect(cornerRadii: .init(topLeading: 6, bottomLeading: 6, bottomTrailing: 6, topTrailing: 6)))
                
                Text("Ukraine's President Zelensky to BBC: Blood money being paid for Russian oil")
                    .padding(.leading,6)
                    .setFont(fontName: .regular, size: 24)
                
                
                Text("Ukrainian President Volodymyr Zelensky has accused European countries that continue to buy Russian oil of \"earning their money in other people's blood\".\n\nIn an interview with the BBC, President Zelensky singled out Germany and Hungary, accusing them of blocking efforts to embargo energy sales, from which Russia stands to make up to £250bn ($326bn) this year.")
                    .padding(.leading,6)
                    .setFont(fontName: .regular, size: 16)
                    .foregroundStyle(Color("#4E4B66"))
                    .padding(.bottom,30)
                
                CustomButton(buttonTitle: "Read More") {
                    print("Button Tapped")
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
                    print("Right button tapped!")
                }) {
                    Image(.share)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                }
                .frame(width: 50,height: 50)
            }
        }
        
    }
}

#Preview {
    KaberNewsDetailsView()
}
