//
//  SessionStorage.swift
//  GpsTracker
//
//  Created by Denis Kravets on 22.01.2026.
//

import Foundation
import Security

protocol SessionStorage: AnyObject {
    var sessionHash: String? { get }
    
    func save(sessionHash: String)
    func clear()
}

final class KeychainSessionStorage {
    
    private let service = "com.squaregps.session"
    private let account = "session_hash"
}

// MARK: SessionStorage implementation

extension KeychainSessionStorage: SessionStorage {
    
    var sessionHash: String? {
        load()
    }
    
    func save(sessionHash: String) {
        let data = Data(sessionHash.utf8)
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        
        let attributes: [CFString: Any] = [
            kSecValueData: data
        ]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query.merging(attributes) { $1 } as CFDictionary, nil)
    }
    
    func clear() {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}

// MARK: Private extensions

private extension KeychainSessionStorage {
    
    func load() -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
}
