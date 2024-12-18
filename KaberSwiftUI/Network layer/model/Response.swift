//
//  Response.swift
//  EgyEaglesTracking
//
//  Created by Mohamed Ali on 22/05/2024.
//

import Foundation

struct Response<T: Codable>: Codable {
    let status: String
    let totalResults: Int
    let articles: T
}
