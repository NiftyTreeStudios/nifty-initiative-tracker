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

    @State private var manualRollPopUpShown: Bool = false
    @State private var manualRollInput: String = ""

    @State var characterSelected: Character = Character(name: "", initiativeRoll: 0, modifier: 0)
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(isEncounter ? encounterCharacters : characters) { character in
                        CharacterRow(character: character)
                            .swipeActions(edge: .leading) {
                                Button {
                                    if isEncounter {
                                        if let index = mobs.firstIndex(of: character) {
                                            mobs[index].initiativeRoll = Int.random(in: 1...20)
                                        }
                                        if let index = characters.firstIndex(of: character) {
                                            characters[index].initiativeRoll = Int.random(in: 1...20)
                                        }
                                    } else {
                                        if let index = characters.firstIndex(of: character) {
                                            characters[index].initiativeRoll = Int.random(in: 1...20)
                                        }
                                    }
                                } label: {
                                    Label("Reroll", systemImage: "arrow.clockwise")
                                }
                                .tint(.mint)

                                Button {
                                    manualRollPopUpShown = true
                                    self.characterSelected = character
                                } label: {
                                    Label("Manual Roll", systemImage: "die.face.5")
                                }
                                .tint(.orange)
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    if isEncounter {
                                        if let index = mobs.firstIndex(of: character) {
                                            mobs.remove(at: index)
                                        }
                                        if let index = characters.firstIndex(of: character) {
                                            characters.remove(at: index)
                                        }
                                    } else {
                                        if let index = characters.firstIndex(of: character) {
                                            characters.remove(at: index)
                                        }
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
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
            .textFieldAlert(
                characterArray: $characters,
                mobsArray: $mobs,
                character: characterSelected,
                isEncounter: isEncounter,
                isShowing: $manualRollPopUpShown,
                text: $manualRollInput,
                placeholder: "Initiative roll",
                title: "Manually add initiative",
                buttonLable: Text("Submit")
            )
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
