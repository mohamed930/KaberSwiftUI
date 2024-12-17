//
//  CustomButton.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI

struct CustomButton: View {
    
    var buttonTitle: String
    var action: () -> ()
    
    
    var body: some View {
        Button(action: {
            action() // Action for the button
        }) {
            Text(buttonTitle)
                .foregroundColor(.white) // Text color
                .setFont(fontName: .medium, size: 16)
                .padding()
                .frame(maxWidth: .infinity) // Full width
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue) // Blue background
                )
        }
        .frame(height: 48) // Height of the button
    }
}

#Preview {
    CustomButton(buttonTitle: "Read more") {}
}
