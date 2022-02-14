//
//  InitiativeRow.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 14.2.2022.
//

import SwiftUI

struct InitiativeRow: View {
    
    let creature: Creature
    
    var body: some View {
        HStack {
            Text(creature.name)
            Spacer()
            Text("\(creature.initiativeRoll + creature.modifier)")
        }
        .font(.title3)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.purple, lineWidth: 5)
        )
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
}

struct InitiativeRow_Previews: PreviewProvider {
    static var previews: some View {
        InitiativeRow(creature: Creature(name: "Test", initiativeRoll: 15, modifier: 1))
    }
}
