//
//  AddNewCharacterView.swift
//  Nifty Initiative Tracker
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

    @Environment(\.dismiss) private var dismiss

    private var isNameValid: Bool {
        !name.isEmpty
    }

    var body: some View {
        NavigationView {
            Form {
                Toggle("Player Character", isOn: $isPC)
                TextField("Name", text: $name)
                if !isNameValid {
                    Text("Name is required")
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                if isPC {
                    TextField("Player", text: $player)
                }
                Stepper("Modifier: \(initiativeModifier)", value: $initiativeModifier)
                ColorPicker("Color", selection: $color)
            }
            .navigationTitle("Add Character")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save changes") {
                        let newCharacter = Character(
                            name: name,
                            initiativeRoll: Int.random(in: 1...20),
                            modifier: initiativeModifier,
                            isPC: isPC,
                            player: player.isEmpty ? nil : player,
                            color: color
                        )
                        if isPC {
                            if characters.firstIndex(of: newCharacter) == nil {
                                characters.append(newCharacter)
                            }
                        } else {
                            if mobs.firstIndex(of: newCharacter) == nil {
                                mobs.append(newCharacter)
                            }
                        }
                        isOpen = false
                        dismiss()
                    }
                    .disabled(!isNameValid)
                }
            }
        }
    }
}
