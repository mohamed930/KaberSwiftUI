//
//  ErrorView.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 20/12/2024.
//

import SwiftUI

struct ErrorView: View {
    
    @Binding var showError: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "info.circle")
                .foregroundColor(.white)
                .font(.title3)
            
            Text("There is no connection")
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
        }
        .padding()
        .background(Color.red)
        .cornerRadius(8)
        .opacity(showError ? 1.0 : 0.0)
        .onTapGesture {
            showError = false
        }
    }
}

#Preview {
    @State var error: Bool = true
    return ErrorView(showError: $error)
}
