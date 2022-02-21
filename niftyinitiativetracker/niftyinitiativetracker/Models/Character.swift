//
//  Character.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import Foundation

protocol Character {
    var id: UUID { get }
    var name: String { get }
    var initiativeRoll: Int { get set }
    var modifier: Int { get set }
    var isPC: Bool { get set }
}
