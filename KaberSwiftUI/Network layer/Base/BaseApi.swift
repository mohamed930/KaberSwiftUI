//
//  BaseApi.swift
//  EgyEaglesTracking
//
//  Created by Mohamed Ali on 22/05/2024.
//

import SwiftUI

class BaseAPI<T:TargetType> {
    func fetchData<M: Decodable>(Target: T) async throws -> M {
        var endpoint = (Target.baseURL.rawValue + Target.path.rawValue)
        
        let params = buildParams(task: Target.task)
        
        if params.1 == .path {
            for (_, value) in params.0 {
                endpoint = endpoint + "/" + "\(value)"
            }
        }
        
//        guard let url = URL(string: endpoint) else { throw ErrorMessage.invalidUrl }
        
        guard var urlComponents = URLComponents(string: endpoint) else { throw ErrorMessage.invalidUrl }
        
        
        if !params.0.isEmpty {
            if params.1 == .QueryEncoding {
                urlComponents.queryItems = params.0.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            }
        }
        
        guard let url = urlComponents.url else { throw ErrorMessage.invalidUrl }
        var request = URLRequest(url: url)
        request.httpMethod = Target.method.rawValue
        
        if params.1 == .URLEnconding {
//            var urlComponents = URLComponents()
//            urlComponents.queryItems = params.0.map { (key, value) in
//                URLQueryItem(name: key, value: "\(value)")
//            }
//            
//            request.httpBody = urlComponents.query?.data(using: .utf8)
            
            let parameterArray = params.0.map { (key, value) -> String in
                return "\(key)=\(value)"
            }
            let bodyString = parameterArray.joined(separator: "&")
            request.httpBody = bodyString.data(using: .utf8)
        }
        
        if params.1 == .JSONEncoding  {
            do {
                // Convert the payload to JSON data
                let jsonData = try JSONSerialization.data(withJSONObject: params.0, options: [])
                request.httpBody = jsonData
            }
        }
        
        if let header = Target.headers, header != [:] {
            // Add the headers to the request
            for (key, value) in header {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if params.1 == .JSONEncoding {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        else {
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // MARK: - Debug
        // -------------------------------------------
        
        print("[\(Target.method.rawValue)] \(urlComponents.url as Any)")
        print("-----------------------------")
        
        print("Query:")
        print("---------------------------")
        print(urlComponents.queryItems ?? [:])
        
        if let body = request.httpBody {
            print("Request body: \(String(data: body, encoding: .utf8) ?? "")")
            print("----------------------------------------")
        }
        else {
            print("Request plain.")
        }
        
        print("Headers:")
        print("---------------------------")
        print(request.allHTTPHeaderFields as Any)
        
        debugJson(data: data)
        // MARK: - EndDebug
        // -------------------------------------------
        
        guard let response = response as? HTTPURLResponse else {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(M.self, from: data)
            }
            catch {
                throw ErrorMessage.invalidResponse
            }
        }
        
        // MARK: - For Debugging.
        print("Response code \(response.statusCode)")
        
        if response.statusCode == 200 || response.statusCode == 201 {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(M.self, from: data)
            }
            catch {
                throw ErrorMessage.invalidData
            }
        }
        else if response.statusCode == 401 {
            throw ErrorMessage.invalidToken
        }
        else {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(M.self, from: data)
            }
            catch {
                throw ErrorMessage.invalidData
            }
        }
        
        
    }
    
    private func buildParams(task: TaskOperation) -> ([String:Any],EncodingType?) {
        switch task {
        case .requestPlain:
            return ([:],nil)
        case .requestParameters(let parameters,let type):
            return (parameters,type)
        }
    }
    
    private func debugJson(data: Data) {
        print("Body:")
        print("-----------------------")
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            
            if let prettyString = String(data: prettyData, encoding: .utf8) {
                print(prettyString)
                print("------------------")
            }
        } catch {
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                print(string)
            }
        }
    }
}
