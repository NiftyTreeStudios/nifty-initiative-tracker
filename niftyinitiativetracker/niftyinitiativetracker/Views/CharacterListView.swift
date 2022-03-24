//
//  ContentView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 14.2.2022.
//

import SwiftUI

struct CharacterListView: View {
    
    @State private var isInEditMode: Bool = false
    
    @State private var isAddingNewCreature: Bool = false
    
    @Binding var mobs: [Character]
    
    @Binding var characters: [Character]
    
    @State private var encounterCharacters: [Character] = []
    
    let isEncounter: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    if isEncounter {
                        ForEach(encounterCharacters, id: \.id) { character in
                            CharacterRow(character: character)
                                .swipeActions(edge: .leading) {
                                    Button {
                                        if let index = mobs.firstIndex(of: character) {
                                            mobs[index].initiativeRoll = Int.random(in: 1...20)
                                        }
                                        if let index = characters.firstIndex(of: character) {
                                            characters[index].initiativeRoll = Int.random(in: 1...20)
                                        }
                                    } label: {
                                        Label("Reroll", systemImage: "arrow.clockwise")
                                    }
                                    .tint(.mint)
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        if let index = mobs.firstIndex(of: character) {
                                            mobs.remove(at: index)
                                        }
                                        if let index = characters.firstIndex(of: character) {
                                            characters.remove(at: index)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    } else {
                        ForEach(characters) { character in
                            CharacterRow(character: character)
                                .swipeActions(edge: .leading) {
                                    Button {
                                        if let index = characters.firstIndex(of: character) {
                                            characters[index].initiativeRoll = Int.random(in: 1...20)
                                        }
                                    } label: {
                                        Label("Reroll", systemImage: "arrow.clockwise")
                                    }
                                    .tint(.mint)
                                }
                                .swipeActions {
                                    Button(role: .destructive) {
                                        if let index = characters.firstIndex(of: character) {
                                            characters.remove(at: index)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
                .listStyle(.plain)
                VStack {
                    if isEncounter {
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
                        }.disabled(encounterCharacters.isEmpty)
                    }
                }.padding()
            }
            .navigationTitle(Text(isEncounter ? "Encounter" : "Party"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItems(
                    isEncounter: isEncounter,
                    characters: $characters,
                    encounterCharacters: $encounterCharacters,
                    isAddingNewCreature: $isAddingNewCreature
                )
            }
            .sheet(isPresented: $isAddingNewCreature) {
                AddNewCharacterView(
                    characters: $characters,
                    mobs: $mobs,
                    isOpen: $isAddingNewCreature,
                    isPC: false,
                    color: .red
                )
            }
            .onChange(of: mobs) { _ in
                encounterCharacters = mobs + characters
            }
            .onChange(of: characters) { _ in
                encounterCharacters = mobs + characters
                saveParty(characters)
            }
        }
        .onAppear {
            characters = loadParty()
            encounterCharacters = mobs + characters
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(mobs: .constant([]), characters: .constant([]), isEncounter: false)
        CharacterListView(mobs: .constant([]), characters: .constant([]), isEncounter: true)
    }
}
