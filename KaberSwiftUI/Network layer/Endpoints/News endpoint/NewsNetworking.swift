//
//  NewsNetworking.swift
//  KaberSwiftUI
//
//  Created by Mohamed Ali on 18/12/2024.
//

import Foundation

enum NewsNetworking {
    case fetchAllNews(q: String,language: String, sortBy: searchKey = .publishedAt,pageSize: Int = 25 ,page: Int)
}

extension NewsNetworking: TargetType {
    var baseURL: Api {
        return .baseURL
    }
    
    var path: Api {
        return .allNews
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var task: TaskOperation {
        switch self {
        case .fetchAllNews(let q,let language, let sortBy,let pageSize,let page):
            var params: [String: Any]!
            if language.isEmpty {
                params = [
                            "q": q,
                            "sortBy": sortBy.rawValue,
                            "pageSize": pageSize,
                            "page": page
                         ]
            }
            else {
                params = [
                            "q": q,
                            "language": language,
                            "sortBy": sortBy.rawValue,
                            "pageSize": pageSize,
                            "page": page
                         ]
            }

            
            print(params ?? [:])
            
            return .requestParameters(parameters: params, endcoding: .QueryEncoding)
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization":"Bearer \(apiToken)"]
    }
    
    
}
