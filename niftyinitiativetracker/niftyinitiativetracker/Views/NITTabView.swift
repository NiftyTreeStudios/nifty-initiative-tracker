//
//  NITTabView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct NITTabView: View {
    
    @State private var characters: [Character] = []
    @State private var mobs: [Character] = []
    
    var body: some View {
        TabView {
            CharacterListView(mobs: $mobs, characters: $characters, isEncounter: true)
                .tabItem {
                    VStack {
                        Image(systemName: "gamecontroller")
                        Text("Encounter")
                    }
                }
                .tag("Encounter")
            CharacterListView(mobs: $mobs, characters: $characters, isEncounter: false)
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
