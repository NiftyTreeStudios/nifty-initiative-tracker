//
//  Creature.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 14.2.2022.
//

import Foundation

struct Creature: Identifiable {
    let id = UUID()
    let name: String
    var initiativeRoll: Int
    var modifier: Int = 0
}
