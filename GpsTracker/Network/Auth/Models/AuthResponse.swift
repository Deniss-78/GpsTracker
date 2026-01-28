//
//  AuthResponse.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

struct AuthResponse: Decodable {
    let success: Bool
    let hash: String?
    let status: APIError?
}
