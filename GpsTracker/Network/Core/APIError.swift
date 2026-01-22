//
//  APIError.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

struct APIError: Decodable {
    let code: Int
    let message: String
}
