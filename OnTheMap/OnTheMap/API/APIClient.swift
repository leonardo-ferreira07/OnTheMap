//
//  APIClient.swift
//  OnTheMap
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 10/10/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import Foundation

public enum URLMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
}

class APIClient: NSObject {
    
    open static func performRequest(_ url: URL, method: URLMethod? = .GET, jsonBody: [String: AnyObject]? = nil, headerValues: [[String]]? = nil, completion:@escaping (_ data: AnyObject?, Error?) -> Void, timeoutAfter timeout: TimeInterval = 0, onTimeout: (()->Void)? = nil) -> URLSessionDataTask? {
        
        func sendError(_ error: String) {
            print(error)
            let userInfo = [NSLocalizedDescriptionKey: error]
            completion(nil, NSError(domain: "performRequest", code: 1, userInfo: userInfo))
        }
        
        let urlRequest = NSMutableURLRequest(url: url)
        
        if let method = method {
            urlRequest.httpMethod = method.rawValue
        }
        
        var data: Data?
        if let jsonBody = jsonBody {
            do {
                try data = JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted)
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            } catch {
                NSLog("Error unwraping json object")
                sendError("Error unwraping json object")
            }
        }
        
        if let bodyData = data {
            urlRequest.httpBody = bodyData
        }
        
        if let headerValues = headerValues {
            for headerValue in headerValues {
                urlRequest.addValue(headerValue[0], forHTTPHeaderField: headerValue[1])
            }
        }
        
        if timeout > 0 {
            urlRequest.timeoutInterval = timeout
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard var data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            if urlRequest.url?.absoluteString.contains("session") ?? false {
                let range = Range(5..<data.count)
                data = data.subdata(in: range)
            }
            
            guard let jsonObject = jsonObject(data) else {
                sendError("error parsing Json")
                return
            }
            
            DispatchQueue.main.async(execute: {
                completion(jsonObject, nil)
            })
        }
        task.resume()
        
        return task
    }
    
    open static func performRequestReturnsData(_ url: URL, method: URLMethod? = .GET, jsonBody: [String: AnyObject]? = nil, headerValues: [[String]]? = nil, completion: @escaping (_ data: Data?, Error?) -> Void, timeoutAfter timeout: TimeInterval = 0, onTimeout: (()->Void)? = nil) -> URLSessionDataTask? {
        
        func sendError(_ error: String) {
            print(error)
            let userInfo = [NSLocalizedDescriptionKey: error]
            completion(nil, NSError(domain: "performRequest", code: 1, userInfo: userInfo))
        }
        
        let urlRequest = NSMutableURLRequest(url: url)
        
        if let method = method {
            urlRequest.httpMethod = method.rawValue
        }
        
        var data: Data?
        if let jsonBody = jsonBody {
            do {
                try data = JSONSerialization.data(withJSONObject: jsonBody, options: .prettyPrinted)
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            } catch {
                NSLog("Error unwraping json object")
                sendError("Error unwraping json object")
            }
        }
        
        if let bodyData = data {
            urlRequest.httpBody = bodyData
        }
        
        if let headerValues = headerValues {
            for headerValue in headerValues {
                urlRequest.addValue(headerValue[0], forHTTPHeaderField: headerValue[1])
            }
        }
        
        if timeout > 0 {
            urlRequest.timeoutInterval = timeout
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
            guard var data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            if urlRequest.url?.absoluteString.contains("session") ?? false {
                let range = Range(5..<data.count)
                data = data.subdata(in: range)
            }
            
            DispatchQueue.main.async(execute: {
                completion(data, nil)
            })
        }
        task.resume()
        
        return task
    }
    
}

// MARK: - URL builder

extension APIClient {
    
    open static func buildURL(_ parameters: [String: AnyObject]? = nil, withHost host: String, withPathExtension path: String) -> URL {
        var components = URLComponents()
        components.scheme = Constants.apiScheme
        components.host = host
        components.path = "/" + path
        
        if let parameters = parameters {
            components.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        
        return components.url!
    }
    
}

// MARK: - JSON Serializer

extension APIClient {
    
    private static func jsonObject(_ data: Data?) -> AnyObject?{
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                return json as AnyObject?
            } catch {
                print("error serializing JSON: \(error)")
            }
        }
        
        return nil
    }
    
}
