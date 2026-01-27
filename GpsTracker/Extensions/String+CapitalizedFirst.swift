//
//  String+CapitalizedFirst.swift
//  GpsTracker
//
//  Created by Denis Kravets on 27.01.2026.
//

extension String {
    
    var capitalizedFirst: String {
        guard let first = first else {
            return self
        }
        return first.uppercased() + dropFirst()
    }
}
