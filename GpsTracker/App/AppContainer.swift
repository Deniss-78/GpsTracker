//
//  AppContainer.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

final class AppContainer {
    
    // MARK: - Core
    
    lazy var apiClient: APIClient = {
        APIClient()
    }()
    
    // MARK: - Storage
    
    lazy var sessionStorage: SessionStorage = {
        KeychainSessionStorage()
    }()
    
    // MARK: - Services
    
    lazy var authService: AuthService = {
        RemoteAuthService(
            apiClient: apiClient,
            sessionStorage: sessionStorage
        )
    }()
    
    lazy var trackersService: TrackersService = {
        RemoteTrackersService(
            apiClient: apiClient,
            authService: authService
        )
    }()
    
    // MARK: - ViewModels
    
    func makeTrackerListViewModel() -> TrackerListViewModel {
        TrackerListViewModel(
            trackersService: trackersService
        )
    }
}
