//
//  AddNewPCView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct AddNewPCView: View {
    
    @Binding var characters: [PlayerCharacter]
    @Binding var isOpen: Bool
    
    @State private var name: String = ""
    @State private var player: String = ""
    @State private var initiativeModifier: Int = 0
    @State private var isPC: Bool = false
    
    var body: some View {
        VStack {
            Text("Add new PC")
                .font(.title2)
            Form {
                TextField("Name", text: $name)
                TextField("Player", text: $player)
                Stepper("Modifier: \(initiativeModifier)", value: $initiativeModifier)
                    
                Toggle("Player character", isOn: $isPC)
            }
            Button {
                characters.append(
                    PlayerCharacter(
                        name: name,
                        player: player,
                        initiativeRoll: Int.random(in: 1...20),
                        modifier: initiativeModifier
                    )
                )
                isOpen = false
            } label: {
                Text("Add new PC")
            }

        }.padding(.vertical)
    }
}
