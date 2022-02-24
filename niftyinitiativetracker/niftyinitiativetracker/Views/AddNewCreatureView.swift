//
//  AddNewCreatureView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct AddNewCreatureView: View {
    
    @Binding var mobs: [Character]
    @Binding var isOpen: Bool
    
    @State private var name: String = ""
    @State private var initiativeModifier: Int = 0
    @State private var isPC: Bool = false
    
    var body: some View {
        VStack {
            Text("Add new character")
                .font(.title2)
            Form {
                TextField("Name", text: $name)
                Stepper("Modifier: \(initiativeModifier)", value: $initiativeModifier)
                    
                Toggle("Player character", isOn: $isPC)
            }
            Button {
                mobs.append(
                    Character(
                        name: name,
                        initiativeRoll: Int.random(in: 1...20),
                        modifier: initiativeModifier,
                        isPC: isPC
                    )
                )
                isOpen = false
            } label: {
                Text("Add new character")
            }

        }.padding(.vertical)
    }
}
