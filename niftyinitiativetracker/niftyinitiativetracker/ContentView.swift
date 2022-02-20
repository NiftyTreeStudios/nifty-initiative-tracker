//
//  ContentView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 14.2.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isInEditMode: Bool = false
    
    @State private var isAddingNewCreature: Bool = false
    
    @State private var creatures: [Creature] = []
    
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
                    }.disabled(creatures.isEmpty)
                }.padding()
            }
            .navigationTitle(Text("Nifty Initiative Tracker"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItems(creatures: $creatures, editMode: $isInEditMode, isAddingNewCreature: $isAddingNewCreature)
            }
            .sheet(isPresented: $isAddingNewCreature) {
                AddNewCreatureView(creatures: $creatures, isOpen: $isAddingNewCreature)
            }

        }
    }
    
    func deleteCreatures(at offsets: IndexSet) {
        creatures.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
