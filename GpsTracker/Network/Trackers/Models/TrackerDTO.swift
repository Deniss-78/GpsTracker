//
//  TrackerDTO.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

struct TrackerDTO: Decodable {
    let id: Int
    let label: String
    let source: TrackerSourceDTO
}
