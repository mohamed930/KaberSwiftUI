//
//  constans.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 18/12/2024.
//

import Foundation

var apiToken = "37ec23115f1f4c94bec11b635203f9b6"

enum Api: String {
    case baseURL = "https://newsapi.org/v2/"
    case allNews = "everything"
}

enum searchKey: String {
    case relevancy
    case popularity
    case publishedAt
}
