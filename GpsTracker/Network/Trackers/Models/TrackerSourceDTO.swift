//
//  TrackerSourceDTO.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

struct TrackerSourceDTO: Decodable {
    
    let model: String
    let deviceID: String
    
    enum CodingKeys: String, CodingKey {
        case model
        case deviceID = "device_id"
    }
}
