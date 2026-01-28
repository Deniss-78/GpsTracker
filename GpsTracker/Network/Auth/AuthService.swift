//
//  AuthService.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import Foundation

protocol AuthService: AnyObject {
    func validSessionHash() async throws -> String
    func invalidateSession()
}

final class RemoteAuthService {
    
    private let apiClient: APIClient
    private let sessionStorage: SessionStorage
    
    init(
        apiClient: APIClient,
        sessionStorage: SessionStorage
    ) {
        self.apiClient = apiClient
        self.sessionStorage = sessionStorage
    }
}

// MARK: AuthService implementation

extension RemoteAuthService: AuthService {
    
    func validSessionHash() async throws -> String {
        guard let validHash = sessionStorage.sessionHash else {
            return try await authenticate()
        }
        return validHash
    }
    
    func invalidateSession() {
        sessionStorage.clear()
    }
}

// MARK: Private extensions

private extension RemoteAuthService {
    
    func authenticate() async throws -> String {
        do {
            let response: AuthResponse = try await apiClient.request(AuthEndpoint.authenticate)
            
            guard response.success else {
                if let status = response.status {
                    throw AuthError.server(status)
                }
                throw AuthError.invalidResponse
            }
            
            guard let hash = response.hash?.trimmingCharacters(in: .whitespacesAndNewlines),
                  !hash.isEmpty else {
                throw AuthError.invalidResponse
            }
            
            sessionStorage.save(sessionHash: hash)
            return hash
            
        } catch let error as NetworkError {
            throw mapNetworkError(error)
        }
        
    }
    
    func mapNetworkError(_ error: NetworkError) -> AuthError {
        switch error {
        case .invalidURL, .invalidResponse, .decoding:
            return .invalidResponse
            
        case .http(_, let data):
            if let apiError = try? JSONDecoder().decode(AuthResponse.self, from: data).status {
                return .server(apiError)
            }
            return .invalidResponse
        }
    }
}
