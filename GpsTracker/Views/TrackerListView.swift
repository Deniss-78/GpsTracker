//
//  TrackerListView.swift
//  GpsTracker
//
//  Created by Denis Kravets on 20.01.2026.
//

import SwiftUI

struct TrackerListView: View {
    
    @StateObject private var viewModel: TrackerListViewModel
    
    init(viewModel: TrackerListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.trackers) { tracker in
                NavigationLink {
                    TrackerDetailsView(tracker: tracker)
                } label: {
                    trackerView(tracker)
                }
            }
            .navigationTitle("Trackers")
            .refreshable {
                await viewModel.load()
            }
            .overlay {
                if viewModel.isLoading && viewModel.trackers.isEmpty {
                    ProgressView()
                }
            }
            .task {
                guard viewModel.trackers.isEmpty else { return }
                await viewModel.load()
            }
        }
    }
}

// MARK: Subviews

private extension TrackerListView {
    
    func trackerView(_ tracker: Tracker) -> some View {
        VStack(alignment: .leading) {
            Text(tracker.label)
                .font(.headline)
            
            Text(tracker.model)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
