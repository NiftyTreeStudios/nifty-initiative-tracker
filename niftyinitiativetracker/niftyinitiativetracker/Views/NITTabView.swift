//
//  NITTabView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct NITTabView: View {
    var body: some View {
        TabView {
            EncounterView()
                .tabItem {
                    VStack {
                        Image(systemName: "gamecontroller")
                        Text("Encounter")
                    }
                }
                .tag("Encounter")
            PartyView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.3")
                        Text("Party")
                    }
                }
                .tag("Party")
        }
    }
}

struct NITTabView_Previews: PreviewProvider {
    static var previews: some View {
        NITTabView()
    }
}
