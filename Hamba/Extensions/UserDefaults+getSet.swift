//
//  UserDefaults+getSet.swift
//  Hamba
//
//  Created by Péter Sanyó on 17.04.24.
//

import Foundation

// Handling enum saving and loading in UserDefaults
extension UserDefaults {
    func getEnum<T: RawRepresentable>(forKey key: String) -> T? where T.RawValue == String {
        guard let rawValue = string(forKey: key) else { return nil }
        return T(rawValue: rawValue)
    }

    func setEnum<T: RawRepresentable>(_ value: T, forKey key: String) where T.RawValue == String {
        set(value.rawValue, forKey: key)
    }
}
