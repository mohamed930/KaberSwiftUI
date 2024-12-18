//
//  ShareSheet.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 18/12/2024.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        activityVC.modalPresentationStyle = .pageSheet
        
        if let sheet = activityVC.sheetPresentationController {
            sheet.detents = [.medium()] // Specify the heights you want
            sheet.prefersGrabberVisible = true // Optional grabber
        }

        return activityVC
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        // Customize behavior for sheet presentation here, if needed.
    }
}
