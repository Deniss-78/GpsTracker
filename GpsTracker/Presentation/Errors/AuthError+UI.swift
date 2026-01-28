//
//  AuthError+UI.swift
//  GpsTracker
//
//  Created by Denis Kravets on 27.01.2026.
//

extension AuthError: ErrorRepresentable {
    
    var message: String {
        switch self {
        case .server(let apiError):
            return apiError.message
            
        case .invalidResponse:
            return Strings.invalidServerResponse.capitalizedFirst
        }
    }
}
