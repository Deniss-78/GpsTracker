//
//  TrackerListViewModel.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import Combine
import Foundation

@MainActor
final class TrackerListViewModel: ObservableObject {
    
    @Published private(set) var trackers: [Tracker] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?
    
    private let trackersService: TrackersService
    
    init(trackersService: TrackersService) {
        self.trackersService = trackersService
    }
    
    func load() async {
        isLoading = true
        errorMessage = nil
        
        do {
            trackers = try await trackersService.fetchTrackers()
        } catch {
            // in real application it's necessary to implement mapping an error for UI
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
