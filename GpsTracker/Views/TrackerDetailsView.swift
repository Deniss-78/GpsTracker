//
//  TrackerDetailsView.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import SwiftUI

struct TrackerDetailsView: View {
    
    let tracker: Tracker
    
    var body: some View {
        Form {
            TrackerInfoRow(
                title: "Model",
                value: tracker.model
            )
            TrackerInfoRow(
                title: "Device ID",
                value: tracker.deviceID
            )
        }
        .navigationTitle(tracker.label)
    }
}
