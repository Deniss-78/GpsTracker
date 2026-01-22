//
//  AuthRequest.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

struct AuthRequest: Encodable {
    let login: String
    let password: String
}
