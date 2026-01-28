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
            .navigationTitle(Strings.trackersTitle.capitalizedFirst)
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
            .alert(
                Strings.error.capitalizedFirst,
                isPresented: Binding(
                    get: {
                        viewModel.errorIsValid()
                    },
                    set: { _ in
                        viewModel.dismissError()
                    }
                )
            ) {
                Button(
                    Strings.commonOk,
                    role: .cancel
                ) {}
            } message: {
                Text(viewModel.fetchErrorMessage())
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
