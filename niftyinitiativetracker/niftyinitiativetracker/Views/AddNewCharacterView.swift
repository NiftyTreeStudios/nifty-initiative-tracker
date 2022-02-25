//
//  AddNewPCView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct AddNewCharacterView: View {
    
    @Binding var characters: [Character]
    @Binding var mobs: [Character]
    @Binding var isOpen: Bool
    
    @State private var name: String = ""
    @State private var player: String = ""
    @State private var initiativeModifier: Int = 0
    @State var isPC: Bool
    @State var color: Color
    
    var body: some View {
        VStack {
            Text("Add new \(isPC ? "" : "N")PC")
                .font(.title2)
            Form {
                Toggle("Player Character", isOn: $isPC)
                TextField("Name", text: $name)
                if isPC {
                    TextField("Player", text: $player)
                }
                Stepper("Modifier: \(initiativeModifier)", value: $initiativeModifier)
                ColorPicker("Color", selection: $color)
            }
            Button {
                let newCharacter = Character(
                    name: name,
                    initiativeRoll: Int.random(in: 1...20),
                    modifier: initiativeModifier,
                    isPC: isPC,
                    player: player,
                    color: color
                )
                if isPC {
                    if characters.firstIndex(of: newCharacter) == nil {
                        characters.append(newCharacter)
                    }
                } else if !isPC {
                    if mobs.firstIndex(of: newCharacter) == nil {
                        mobs.append(newCharacter)
                    }
                }
                isOpen = false
            } label: {
                Text("Add new character")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 50)
                    .background {
                        Capsule()
                            .foregroundColor(.blue)
                    }
            }

        }.padding(.vertical)
    }
}
