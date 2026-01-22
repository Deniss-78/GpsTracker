//
//  TrackerInfoRow.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import SwiftUI

struct TrackerInfoRow: View {
    
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}
