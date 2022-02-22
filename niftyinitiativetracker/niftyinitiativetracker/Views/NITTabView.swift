//
//  NITTabView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct NITTabView: View {
    
    @State private var characters: [PlayerCharacter] = []
    @State private var creatures: [Creature] = []
    
    var body: some View {
        TabView {
            EncounterView(creatures: $creatures, characters: $characters)
                .tabItem {
                    VStack {
                        Image(systemName: "gamecontroller")
                        Text("Encounter")
                    }
                }
                .tag("Encounter")
            PartyView(characters: $characters)
                .tabItem {
                    VStack {
                        Image(systemName: "person.3")
                        Text("Party")
                    }
                }
                .tag("Party")
        }.onAppear {
            characters = loadParty()
        }
    }
}

struct NITTabView_Previews: PreviewProvider {
    static var previews: some View {
        NITTabView()
    }
}
