//
//  Creature.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 14.2.2022.
//

import Foundation

struct Creature: Character, Identifiable, Equatable {
    let id = UUID()
    let name: String
    var initiativeRoll: Int
    var modifier: Int = 0
    var isPC: Bool = false
}
