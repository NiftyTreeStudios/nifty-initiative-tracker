//
//  ContentView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 14.2.2022.
//

import SwiftUI

struct ContentView: View {
    
    var creatures: [Creature] = [
        Creature(
            name: "Creature",
            initiativeRoll: 12,
            modifier: 3
        ),
        Creature(
            name: "Creature2",
            initiativeRoll: 12,
            modifier: 3
        )
    ]
    
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(creatures) { creature in
                    InitiativeRow(creature: creature)
                }
            }
            .navigationTitle(Text("Nifty Initiative Tracker"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
