//
//  ContentView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 14.2.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var creatures: [Creature] = [
        Creature(
            name: "Creature",
            initiativeRoll: 12,
            modifier: 3
        ),
        Creature(
            name: "Creature2",
            initiativeRoll: 12,
            modifier: 1
        ),
        Creature(
            name: "PC",
            initiativeRoll: 13,
            modifier: 6,
            isPC: true
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
            .toolbar {
                Button {
                    print("Sort")
                    creatures.sort {
                        ($0.initiativeRoll + $0.modifier) > ($1.initiativeRoll + $1.modifier)
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }

            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
