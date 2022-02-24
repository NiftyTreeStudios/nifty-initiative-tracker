//
//  PartyCoder.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 22.2.2022.
//

import Foundation

/// Saves party into user defaults.
/// - Parameters:
///   - party: The `Character` array that is being saved.
func saveParty(_ party: [Character]) {
    let data = party.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "Party")
}

/// Loads party from user defaults.
/// - Returns: A array of `Character`.
func loadParty() -> [Character] {
    guard let encodedData = UserDefaults.standard.array(forKey: "Party") as? [Data] else {
        return []
    }
    let decoder = JSONDecoder()
    var party = [Character]()
    for character in encodedData {
        if let character = try? decoder.decode(Character.self, from: character) {
            party.append(character)
        }
    }
    return party
    // return encodedData.map { try JSONDecoder().decode(Character.self, from: $0) }
}
