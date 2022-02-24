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
    
    @Binding var mobs: [Character]
    
    @Binding var characters: [Character]
    
    @State private var encounterCharacters: [Character] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    ForEach(encounterCharacters, id: \.id) { character in
                        HStack {
                            if isInEditMode {
                                Button {
                                    if let index = encounterCharacters.firstIndex(where: { $0.id == character.id }) {
                                        encounterCharacters.remove(at: index)
                                    }
                                    if let index = mobs.firstIndex(where: { $0.id == character.id }) {
                                        mobs.remove(at: index)
                                    }
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .font(.title3)
                                        .foregroundColor(.red)
                                }
                                .padding(.leading)
                                .padding(.trailing, -10)
                            }
                            CharacterRow(character: character)
                        }
                    }
                    .onDelete { index in
                        deleteCreatures(at: index)
                    }
                }
                VStack {
                    Spacer()
                    Button {
                        let creature = encounterCharacters.first
                        encounterCharacters.removeFirst()
                        encounterCharacters.append(creature!)
                    } label: {
                        Text("Take turn")
                            .foregroundColor(.white)
                            .padding()
                            .padding(.horizontal, 50)
                            .background {
                                Capsule()
                                    .foregroundColor(encounterCharacters.isEmpty ? .gray.opacity(0.5) : .blue)
                            }
                    }.disabled(mobs.isEmpty)
                }.padding()
            }
            .navigationTitle(Text("Encounter"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItems(creatures: $encounterCharacters, editMode: $isInEditMode, isAddingNewCreature: $isAddingNewCreature)
            }
            .sheet(isPresented: $isAddingNewCreature) {
                AddNewCreatureView(mobs: $mobs, isOpen: $isAddingNewCreature)
            }
            .onChange(of: mobs) { newValue in
                encounterCharacters = mobs + characters
            }
        }
        .onAppear {
            encounterCharacters = mobs + characters
        }
    }
    
    func deleteCreatures(at offsets: IndexSet) {
        mobs.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EncounterView(mobs: .constant([]), characters: .constant([]))
    }
}
