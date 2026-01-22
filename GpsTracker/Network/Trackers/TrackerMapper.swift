//
//  TrackerMapper.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import Foundation

enum TrackerMapper {
    
    static func map(_ dto: TrackerDTO) -> Tracker {
        Tracker(
            id: dto.id,
            label: dto.label,
            model: dto.source.model,
            deviceID: dto.source.deviceID
        )
    }
}
