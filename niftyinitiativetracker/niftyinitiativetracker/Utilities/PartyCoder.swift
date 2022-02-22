//
//  PartyCoder.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 22.2.2022.
//

import Foundation

/// Saves party into user defaults.
/// - Parameters:
///   - party: The `PlayerCharacter` array that is being saved.
func saveParty(_ party: [PlayerCharacter]) {
    let data = party.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "Party")
}

/// Loads party from user defaults.
/// - Returns: A array of `PlayerCharacter`.
func loadParty() -> [PlayerCharacter] {
    guard let encodedData = UserDefaults.standard.array(forKey: "Party") as? [Data] else {
        return []
    }
    return encodedData.map { try! JSONDecoder().decode(PlayerCharacter.self, from: $0) }
}
