//
//  TrackersError.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

enum TrackersError: Error {
    case wrongHash
    case server(APIError)
    case invalidResponse
}
