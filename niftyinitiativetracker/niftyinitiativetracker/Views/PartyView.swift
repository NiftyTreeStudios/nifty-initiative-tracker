//
//  PartyView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct PartyView: View {
    
    @State private var isInEditMode: Bool = false
    
    @State private var isAddingNewPC: Bool = false
    
    @Binding var characters: [PlayerCharacter]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    ForEach(characters) { character in
                        HStack {
                            if isInEditMode {
                                Button {
                                    if let index = characters.firstIndex(of: character) {
                                        characters.remove(at: index)
                                    }
                                } label: {
                                    Image(systemName: "minus.circle")
                                }

                            }
                            CharacterRow(character: character)
                        }
                    }
                    .onDelete { index in
                        deleteCharacters(at: index)
                    }
                }
            }
            .navigationTitle(Text("Party"))
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup {
                    HStack {
                        Button {
                            isInEditMode.toggle()
                        } label: {
                            Text("Edit")
                        }.disabled(characters.isEmpty)
                        Button {
                            isAddingNewPC = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $isAddingNewPC) {
                AddNewPCView(characters: $characters, isOpen: $isAddingNewPC)
            }

        }
    }
    
    func deleteCharacters(at offsets: IndexSet) {
        characters.remove(atOffsets: offsets)
    }
    
}

struct PartyView_Previews: PreviewProvider {
    static var previews: some View {
        PartyView(characters: .constant([]))
    }
}
