//
//  TextFieldAlert.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 12.4.2022.
//

import SwiftUI

struct TextFieldAlert<Presenting>: View where Presenting: View {

    @Binding var characterArray: [Character]
    @Binding var mobsArray: [Character]
    let character: Character
    let isEncounter: Bool

    @Binding var isShowing: Bool
    @Binding var text: String
    let placeholder: String
    let presenting: Presenting
    let title: String
    let buttonLabel: Text

    var body: some View {
        GeometryReader { (deviceSize: GeometryProxy) in
            ZStack {
                self.presenting
                    .disabled(isShowing)
                VStack(alignment: .center) {
                    VStack {
                        Text(self.title)
                            .font(.title3)

                        TextField(placeholder, text: self.$text)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                            .keyboardType(.numberPad)

                        HStack {
                            Button(action: {
                                manualRoll()
                                withAnimation {
                                    self.isShowing.toggle()
                                }
                            }) {
                                buttonLabel
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 50)
                                    .padding(.vertical)
                                    .background(.blue)
                                    .cornerRadius(30)
                            }
                        }.padding(10)
                    }
                    .frame(width: deviceSize.size.width * 0.6, alignment: .center)
                }
                .padding()
                .frame(
                    width: deviceSize.size.width,
                    height: deviceSize.size.height
                )
                .ignoresSafeArea()
                .shadow(radius: 1)
                .background(.thinMaterial)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }

    func manualRoll() {
        let roll = Int(text) ?? 0
        if isEncounter {
            if let index = mobsArray.firstIndex(of: character) {
                mobsArray[index].initiativeRoll = roll - mobsArray[index].modifier
            }
        }
        if let index = characterArray.firstIndex(of: character) {
            characterArray[index].initiativeRoll = roll - characterArray[index].modifier
        }
    }

}
