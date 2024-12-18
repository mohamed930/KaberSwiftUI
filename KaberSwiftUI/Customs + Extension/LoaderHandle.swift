//
//  LoaderHandle.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 18/12/2024.
//

import SwiftUI
import RappleProgressHUD

extension View {
    
    func handleLoading(isLoading: Binding<Bool>) -> some View {
        self.onChange(of: isLoading.wrappedValue) { value in
            if value {
                RappleActivityIndicatorView.startAnimatingWithLabel(String(localized: "Please wait"), attributes: RappleModernAttributes)
            } else {
                RappleActivityIndicatorView.stopAnimation()
            }
        }
    }
}
