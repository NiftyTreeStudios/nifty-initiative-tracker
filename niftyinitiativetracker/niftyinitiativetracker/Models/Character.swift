//
//  Character.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import Foundation

struct Character: Identifiable, Equatable, Codable  {
    var id = UUID()
    var name: String
    var initiativeRoll: Int
    var modifier: Int
    var isPC: Bool = false
    var player: String? = nil
}

extension Character {
    mutating func rerollInitiative() {
        self.initiativeRoll = Int.random(in: 1...20) + self.modifier
    }
}
