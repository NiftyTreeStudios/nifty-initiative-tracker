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
                        }.onDelete { index in
                            deleteCreatures(at: index, isPartyView: false)
                        }
                    } else {
                        ForEach(characters) { character in
                            CharacterRow(character: character)
                        }.onDelete { index in
                            deleteCreatures(at: index, isPartyView: true)
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
    
    func deleteCreatures(at offsets: IndexSet, isPartyView: Bool) {
        let character = encounterCharacters[offsets.first!]
        encounterCharacters.removeAll(where: { $0.id == character.id })
        mobs.removeAll(where: { $0.id == character.id })
        if isPartyView {
            characters.removeAll(where: { $0.id == character.id })
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(mobs: .constant([]), characters: .constant([]), isEncounter: false)
        CharacterListView(mobs: .constant([]), characters: .constant([]), isEncounter: true)
    }
}
