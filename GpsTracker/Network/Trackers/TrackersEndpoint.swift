//
//  TrackersEndpoint.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import Foundation

enum TrackersEndpoint: Endpoint {
    
    case list(sessionHash: String)
    
    var path: String {
        "tracker/list"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .list(let hash):
            return [URLQueryItem(name: "hash", value: hash)]
        }
    }
    
    var body: Data? {
        nil
    }
}
