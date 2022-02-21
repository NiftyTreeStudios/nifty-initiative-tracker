//
//  ContentView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 14.2.2022.
//

import SwiftUI

struct EncounterView: View {
    
    @State private var isInEditMode: Bool = false
    
    @State private var isAddingNewCreature: Bool = false
    
    @Binding var creatures: [Creature]
    
    @Binding var characters: [PlayerCharacter]
    
    @State private var encounterCreatures: [Character] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    ForEach(encounterCreatures, id: \.id) { character in
                        HStack {
                            if isInEditMode {
                                Button {
                                    if let index = encounterCreatures.firstIndex(where: { $0.id == character.id }) {
                                        encounterCreatures.remove(at: index)
                                    }
                                    if let index = creatures.firstIndex(where: { $0.id == character.id }) {
                                        creatures.remove(at: index)
                                    }
                                    if let index = characters.firstIndex(where: { $0.id == character.id }) {
                                        characters.remove(at: index)
                                    }
                                } label: {
                                    Image(systemName: "minus.circle")
                                }

                            }
                            InitiativeRow(creature: character)
                        }
                    }
                    .onDelete { index in
                        deleteCreatures(at: index)
                    }
                }
                VStack {
                    Spacer()
                    Button {
                        let creature = encounterCreatures.first
                        encounterCreatures.removeFirst()
                        encounterCreatures.append(creature!)
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
            .navigationTitle(Text("Encounter"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItems(creatures: $encounterCreatures, editMode: $isInEditMode, isAddingNewCreature: $isAddingNewCreature)
            }
            .sheet(isPresented: $isAddingNewCreature) {
                AddNewCreatureView(creatures: $creatures, isOpen: $isAddingNewCreature)
            }
            .onChange(of: creatures) { newValue in
                encounterCreatures = creatures + characters
            }
        }
        .onAppear {
            encounterCreatures = creatures + characters
        }
    }
    
    func deleteCreatures(at offsets: IndexSet) {
        creatures.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EncounterView(creatures: .constant([]), characters: .constant([]))
    }
}
