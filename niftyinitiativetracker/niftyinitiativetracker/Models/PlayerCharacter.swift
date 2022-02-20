//
//  PlayerCharacter.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import Foundation

struct PlayerCharacter: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let player: String?
    var initiativeRoll: Int
    var modifier: Int = 0
    let isPC: Bool = true
}
