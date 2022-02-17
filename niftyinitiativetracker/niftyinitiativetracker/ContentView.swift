//
//  ContentView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 14.2.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isInEditMode: Bool = false
    
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
            ZStack {
                ScrollView {
                    ForEach(creatures) { creature in
                        HStack {
                            if isInEditMode {
                                Button {
                                    if let index = creatures.firstIndex(of: creature) {
                                        creatures.remove(at: index)
                                    }
                                } label: {
                                    Image(systemName: "minus.circle")
                                }

                            }
                            InitiativeRow(creature: creature)
                        }
                    }
                    .onDelete { index in
                        deleteCreatures(at: index)
                    }
                }
                VStack {
                    Spacer()
                    Button {
                        let creature = creatures.first
                        creatures.removeFirst()
                        creatures.append(creature!)
                    } label: {
                        Text("Take turn")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal, 50)
                            .background {
                                Capsule()
                                    .foregroundColor(.blue)
                            }
                    }
                }
            }
            .navigationTitle(Text("Nifty Initiative Tracker"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItems(creatures: $creatures, editMode: $isInEditMode)
            }
        }
    }
    
    func deleteCreatures(at offsets: IndexSet) {
        creatures.remove(atOffsets: offsets)
    }
    
}

struct ToolbarItems: ToolbarContent {
    
    @Binding var creatures: [Creature]
    
    @Binding var editMode: Bool
    
    var body: some ToolbarContent {
        ToolbarItemGroup {
            HStack {
                Button {
                    editMode.toggle()
                } label: {
                    Text("Edit")
                }
                Spacer()
                Button {
                    creatures.sort {
                        ($0.initiativeRoll + $0.modifier) > ($1.initiativeRoll + $1.modifier)
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                }
                Button {
                    creatures.append(
                        Creature(
                            name: "New character",
                            initiativeRoll: Int.random(in: 1...20),
                            modifier: Int.random(in: 0...5),
                            isPC: Bool.random()
                        )
                    )
                } label: {
                    Image(systemName: "plus")
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
