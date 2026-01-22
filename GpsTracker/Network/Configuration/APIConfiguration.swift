//
//  APIConfiguration.swift
//  GpsTracker
//
//  Created by Denis Kravets on 21.01.2026.
//

import Foundation

enum APIConfiguration {
    static let baseURL = URL(string: "https://api.eu.navixy.com/v2/")!
    
    enum Credentials {
        static let login = "demo-eu@navixy.com"
        static let password = "123456"
    }
}
