//
//  NetworkLogger.swift
//  GpsTracker
//
//  Created by Denis Kravets on 21.01.2026.
//

import Foundation

enum NetworkLogger {
    
    static func logRequest(_ request: URLRequest) {
        print("----------")
        print("REQUEST:")
        print("URL:", request.url?.absoluteString ?? Strings.unknown)
        print("METHOD:", request.httpMethod ?? Strings.unknown)
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("BODY:", bodyString)
        }
    }
    
    static func logResponse(data: Data, response: URLResponse) {
        print("----------")
        print("RESPONSE:")
        
        if let httpResponse = response as? HTTPURLResponse {
            print("STATUS CODE:", httpResponse.statusCode)
        }
        
        if let bodyString = String(data: data, encoding: .utf8) {
            print("BODY:", bodyString)
        }
    }
}
