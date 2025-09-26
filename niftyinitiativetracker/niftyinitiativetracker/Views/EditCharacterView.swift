import SwiftUI

struct EditCharacterView: View {
    @Binding var character: Character
    @State private var draft: Character
    @Environment(\.dismiss) private var dismiss
    
    init(character: Binding<Character>) {
        self._character = character
        self._draft = State(initialValue: character.wrappedValue)
    }
    
    private var isNameValid: Bool {
        !draft.name.isEmpty
    }
    
    private var playerBinding: Binding<String> {
        Binding(
            get: { draft.player ?? "" },
            set: { draft.player = $0.isEmpty ? nil : $0 }
        )
    }
    
    var body: some View {
        NavigationView {
            Form {
                Toggle("Player Character", isOn: $draft.isPC)
                TextField("Name", text: $draft.name)
                if !isNameValid {
                    Text("Name is required")
                        .font(.footnote)
                        .foregroundColor(.red)
                }
                if draft.isPC {
                    TextField("Player", text: playerBinding)
                }
                Stepper("Modifier: \(draft.modifier)", value: $draft.modifier)
                ColorPicker("Color", selection: $draft.color)
                Stepper("Initiative Roll: \(draft.initiativeRoll)", value: $draft.initiativeRoll)
            }
            .navigationTitle("Edit Character")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save changes") {
                        character = draft
                        dismiss()
                    }
                    .disabled(!isNameValid)
                }
            }
        }
    }
}

#Preview {
    EditCharacterView(
        character: .constant(
            Character(
                name: "Sample",
                initiativeRoll: 10,
                modifier: 2,
                isPC: true,
                player: "Player",
                color: .blue
            )
        )
    )
}

