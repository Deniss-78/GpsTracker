//
//  NetworkError.swift
//  GpsTracker
//
//  Created by Denis Kravets on 21.01.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case http(code: Int, data: Data)
}
