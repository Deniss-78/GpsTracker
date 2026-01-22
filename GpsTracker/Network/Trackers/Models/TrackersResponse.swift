//
//  TrackersResponse.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

struct TrackersResponse: Decodable {
    let success: Bool
    let list: [TrackerDTO]
    let status: APIError?
}
