//
//  ToolbarItems.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct ToolbarItems: ToolbarContent {
    
    @Binding var creatures: [Creature]
    
    @Binding var editMode: Bool
    
    @Binding var isAddingNewCreature: Bool
    
    var body: some ToolbarContent {
        ToolbarItemGroup {
            HStack {
                Button {
                    editMode.toggle()
                } label: {
                    Text("Edit")
                }.disabled(creatures.isEmpty)
                Spacer()
                Button {
                    creatures.sort {
                        ($0.initiativeRoll + $0.modifier) > ($1.initiativeRoll + $1.modifier)
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }.disabled(creatures.isEmpty)
                Button {
                    isAddingNewCreature = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
