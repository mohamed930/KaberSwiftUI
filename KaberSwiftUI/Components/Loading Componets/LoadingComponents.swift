//
//  LoadingComponents.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 21/12/2024.
//

import SwiftUI

struct LoadingComponents: View {
    
    @Binding var isloading: Bool
    
    var body: some View {
        
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(height: isloading ? 30 : 0)
        .opacity(isloading ? 1: 0)
        
    }
}

#Preview {
     @State var isloading: Bool = false
    
    return LoadingComponents(isloading: $isloading)
}
