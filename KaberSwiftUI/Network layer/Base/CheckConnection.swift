//
//  CheckConnection.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 20/12/2024.
//

import Foundation
import Combine
import Reachability

final class CheckConnection {
    //declare this property where it won't go out of scope relative to your listener
    private let reachability = try! Reachability()
    
    enum connectionStatus {
        case unspecified
        case connected
        case disconnected
        case error
    }
    
    private var connectionStatusPublisher = CurrentValueSubject<connectionStatus,Never>(.unspecified)
    var connectionStatusObservable: AnyPublisher<connectionStatus,Never> {
        return connectionStatusPublisher.eraseToAnyPublisher()
    }
    
    func startNotify() {
        reachability.whenReachable = { [weak self] reachability in
            guard let self = self else { return }
            
            self.connectionStatusPublisher.send(.connected)
            
        }
        reachability.whenUnreachable = { [weak self] _ in
            guard let self = self else { return }
            self.connectionStatusPublisher.send(.disconnected)
        }

        do {
            try reachability.startNotifier()
        } catch {
            self.connectionStatusPublisher.send(.error)
        }
    }
}
