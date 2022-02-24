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
    
    @Binding var editMode: Bool
    
    @Binding var isAddingNewCreature: Bool
    
    var body: some ToolbarContent {
        ToolbarItemGroup {
            HStack {
                Button {
                    editMode.toggle()
                } label: {
                    Text("Edit")
                }.disabled(characters.isEmpty)
                Spacer()
                if isEncounter {
                    Button {
                        characters.sort {
                            ($0.initiativeRoll + $0.modifier) > ($1.initiativeRoll + $1.modifier)
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                    }.disabled(characters.isEmpty)
                } else {
                    Button {
                        for index in 0..<characters.count {
                            var character = characters[index]
                            character.rerollInitiative()
                            characters[index] = character
                        }
                        print(characters)
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
            .onChange(of: characters) { _ in
                saveParty(characters)
            }
        }
    }
}
