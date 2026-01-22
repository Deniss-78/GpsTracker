//
//  APIClient.swift
//  GpsTracker
//
//  Created by Denis Kravets on 21.01.2026.
//

import Foundation

final class APIClient {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try makeRequest(from: endpoint)
        NetworkLogger.logRequest(request)
        
        let (data, response) = try await session.data(for: request)
        NetworkLogger.logResponse(data: data, response: response)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(response.statusCode) else {
            throw NetworkError.http(
                code: response.statusCode,
                data: data
            )
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}

// MARK: Private extensions

private extension APIClient {
    
    func makeRequest(from endpoint: Endpoint) throws -> URLRequest {
        var components = URLComponents(
            url: APIConfiguration.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = endpoint.queryItems
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        if endpoint.body != nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
}
