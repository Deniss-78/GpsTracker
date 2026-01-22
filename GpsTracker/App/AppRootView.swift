//
//  AppRootView.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import SwiftUI

struct AppRootView: View {
    
    private let container = AppContainer()
    
    var body: some View {
        TrackerListView(viewModel: container.makeTrackerListViewModel())
    }
}
