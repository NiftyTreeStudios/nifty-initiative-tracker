//
//  AddNewPCView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct AddNewPCView: View {
    
    @Binding var characters: [Character]
    @Binding var isOpen: Bool
    
    @State private var name: String = ""
    @State private var player: String = ""
    @State private var initiativeModifier: Int = 0
    @State private var isPC: Bool = false
    @State private var color: Color = .blue
    
    var body: some View {
        VStack {
            Text("Add new PC")
                .font(.title2)
            Form {
                TextField("Name", text: $name)
                TextField("Player", text: $player)
                Stepper("Modifier: \(initiativeModifier)", value: $initiativeModifier)
            }
            Button {
                characters.append(
                    Character(
                        name: name,
                        initiativeRoll: Int.random(in: 1...20),
                        modifier: initiativeModifier,
                        isPC: true,
                        player: player,
                        color: color
                    )
                )
                isOpen = false
            } label: {
                Text("Add new PC")
            }

        }.padding(.vertical)
    }
}
