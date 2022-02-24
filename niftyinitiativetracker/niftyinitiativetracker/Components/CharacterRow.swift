//
//  CharacterRow.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct CharacterRow: View {
    
    let character: Character
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title3)
                if let player = character.player {
                    Text(player)
                        .font(.caption2)
                }
            }
            Spacer()
            Text("\(character.initiativeRoll + character.modifier)")
                .font(.title3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .stroke(
                    LinearGradient(
                        colors: [character.color, character.color.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
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

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        CharacterRow(character:
                        Character(
                            name: "Skaar Lonehunter Hulkar",
                            initiativeRoll: Int.random(in: 1...20),
                            modifier: 18,
                            isPC: true,
                            player: "Iiro"
                        )
        )
    }
}
