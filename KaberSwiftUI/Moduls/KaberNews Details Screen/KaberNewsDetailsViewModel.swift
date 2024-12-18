//
//  KaberNewsDetailsViewModel.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 18/12/2024.
//

import SwiftUI
import UIKit

class KaberNewsDetailsViewModel: ObservableObject {
    
    @Published var showSafari = false
    @Published var showShareSheet = false
    
    var article: ArticleModel
    
    init(article: ArticleModel) {
        self.article = article
    }
    
    func shareContent() {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first,
              let rootViewController = window.rootViewController else {
            return
        }
        
        let textToShare = article.url
        let itemsToShare = [textToShare] // Add more items if needed (e.g., URLs, images)
        
        let activityViewController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        // Find the topmost view controller to present the share sheet
        var topViewController = rootViewController
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        
        topViewController.present(activityViewController, animated: true)
    }
}
