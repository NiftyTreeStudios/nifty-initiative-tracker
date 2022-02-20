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
            Text("\(getInitiativeCount(roll: creature.initiativeRoll, modifier: creature.modifier))")
        }
        .font(.title3)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(
                    creature.isPC ? .blue : .red,
                    lineWidth: 5
                )
        )
        .padding(.horizontal)
        .padding(.bottom, 5)
    }
    
    private func getInitiativeCount(roll: Int, modifier: Int) -> Int {
        let initiative = roll + modifier
        if initiative > 0 {
            return initiative
        } else {
            return 0
        }
    }
}

struct InitiativeRow_Previews: PreviewProvider {
    static var previews: some View {
        InitiativeRow(creature: Creature(name: "Test", initiativeRoll: 15, modifier: 1))
    }
}
