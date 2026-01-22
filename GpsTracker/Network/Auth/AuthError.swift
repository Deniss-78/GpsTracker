//
//  AuthError.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

enum AuthError: Error {
    case server(APIError)
    case invalidResponse
}
