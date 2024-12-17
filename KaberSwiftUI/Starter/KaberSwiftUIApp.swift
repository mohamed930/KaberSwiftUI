//
//  KaberSwiftUIApp.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI

@main
struct KaberSwiftUIApp: App {
    
    @StateObject private var navigationManager = NavigationPathManager()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                DismissKeyboardOnTap() // Global tap gesture for keyboard dismissal
                KaberNewsView()
                    .environmentObject(navigationManager)
            }
        }
    }
}
