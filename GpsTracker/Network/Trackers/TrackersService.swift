//
//  TrackersService.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import Foundation

protocol TrackersService: AnyObject {
    func fetchTrackers() async throws -> [Tracker]
}

final class RemoteTrackersService {
    
    private let apiClient: APIClient
    private let authService: AuthService
    
    init(
        apiClient: APIClient,
        authService: AuthService
    ) {
        self.apiClient = apiClient
        self.authService = authService
    }
}

// MARK: TrackersService implementation

extension RemoteTrackersService: TrackersService {
    
    func fetchTrackers() async throws -> [Tracker] {
        do {
            return try await fetchTrackersInternal()
        } catch TrackersError.wrongHash {
            authService.invalidateSession()
            return try await fetchTrackersInternal()
        } catch let error as NetworkError {
            throw mapNetworkError(error)
        }
    }
}

// MARK: Private extensions

private extension RemoteTrackersService {
    
    func fetchTrackersInternal() async throws -> [Tracker] {
        let sessionHash = try await authService.validSessionHash()
        
        let response: TrackersResponse = try await apiClient.request(TrackersEndpoint.list(sessionHash: sessionHash))
        
        guard response.success else {
            guard let status = response.status else {
                throw TrackersError.invalidResponse
            }
            if let error = APIErrorCode(rawValue: status.code),
               error == .wrongHash {
                throw TrackersError.wrongHash
            }
            throw TrackersError.server(status)
        }
        
        guard let list = response.list else {
            throw TrackersError.invalidResponse
        }
        
        return list.map(TrackerMapper.map)
    }
    
    func mapNetworkError(_ error: NetworkError) -> TrackersError {
        switch error {
        case .invalidURL, .invalidResponse, .decoding:
            return .invalidResponse
            
        case .http(_, let data):
            if let apiError = try? JSONDecoder().decode(TrackersResponse.self, from: data).status {
                return .server(apiError)
            }
            return .invalidResponse
        }
    }
}
