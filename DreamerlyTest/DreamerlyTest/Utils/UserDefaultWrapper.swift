//
//  UserDefaultWrapper.swift
//  DreamerlyTest
//
//  Created by Long Quách on 10/09/2024.
//

import Foundation

@propertyWrapper
struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }
            
            // Convert data to desire data type
            do {
                let value = try PropertyListDecoder().decode([T].self, from: data)
                return value.first ?? defaultValue
            }
            catch {
                print("Storage error: \(error)")
            }
            
            return defaultValue
        }
        set {
            do {
                // Convert to data
                let data = try PropertyListEncoder().encode([newValue])
                
                // save to UserDefaults
                UserDefaults.standard.set(data, forKey: key)
            }
            catch {
                print("Storage error: \(error)")
            }
        }
    }
}
