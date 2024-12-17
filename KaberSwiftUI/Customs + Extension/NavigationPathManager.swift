//
//  NavigationPathManager.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 17/12/2024.
//

import SwiftUI

class NavigationPathManager: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    
    func backToRoot() {
        path.removeLast(path.count)
    }
    
    func backToScreen() {
        path.removeLast()
    }
}
