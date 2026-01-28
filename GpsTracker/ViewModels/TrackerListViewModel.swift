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
    @Published private(set) var errorMessage: String?
    
    private let trackersService: TrackersService
    
    init(trackersService: TrackersService) {
        self.trackersService = trackersService
    }
}

extension TrackerListViewModel {
    
    func load() async {
        isLoading = true
        errorMessage = nil
        
        do {
            trackers = try await trackersService.fetchTrackers()
        } catch {
            errorMessage = mapError(error)
        }
        
        isLoading = false
    }
    
    func fetchErrorMessage() -> String {
        errorMessage ?? Strings.commonError.capitalizedFirst
    }
    
    func dismissError() {
        errorMessage = nil
    }
    
    func errorIsValid() -> Bool {
        errorMessage != nil
    }
}

// MARK: Private extensions

private extension TrackerListViewModel {
    
    func mapError(_ error: Error) -> String {
        guard let error = error as? ErrorRepresentable else {
            return Strings.commonError.capitalizedFirst
        }
        return error.message
    }
}
