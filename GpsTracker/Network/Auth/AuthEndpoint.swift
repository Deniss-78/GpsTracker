//
//  AuthEndpoint.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import Foundation

enum AuthEndpoint: Endpoint {
    
    case authenticate
    
    var path: String {
        "user/auth"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
    
    var body: Data? {
        let request = AuthRequest(
            login: APIConfiguration.Credentials.login,
            password: APIConfiguration.Credentials.password
        )
        return try? JSONEncoder().encode(request)
    }
}
