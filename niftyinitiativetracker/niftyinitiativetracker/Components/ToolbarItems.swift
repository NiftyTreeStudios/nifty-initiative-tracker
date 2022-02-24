//
//  ToolbarItems.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct ToolbarItems: ToolbarContent {
    
    let isEncounter: Bool
    
    @Binding var characters: [Character]
    
    @Binding var encounterCharacters: [Character]
    
    @Binding var isAddingNewCreature: Bool
    
    var body: some ToolbarContent {
        ToolbarItemGroup {
            HStack {
                Spacer()
                if isEncounter {
                    Button {
                        encounterCharacters.sort {
                            ($0.initiativeRoll + $0.modifier) > ($1.initiativeRoll + $1.modifier)
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }.disabled(encounterCharacters.isEmpty)
                } else {
                    Button {
                        for index in 0..<characters.count {
                            var character = characters[index]
                            character.rerollInitiative()
                            characters[index] = character
                        }
                        saveParty(characters)
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }.disabled(characters.isEmpty)
                }
                Button {
                    isAddingNewCreature = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
