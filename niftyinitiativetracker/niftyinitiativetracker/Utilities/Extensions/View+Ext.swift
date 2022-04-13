//
//  View+Ext.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 12.4.2022.
//

import SwiftUI

extension View {
    func textFieldAlert(
        characterArray: Binding<[Character]>,
        mobsArray: Binding<[Character]>,
        character: Character,
        isEncounter: Bool,
        isShowing: Binding<Bool>,
        text: Binding<String>,
        placeholder: String,
        title: String,
        buttonLable: Text
    ) -> some View {
        TextFieldAlert(
            characterArray: characterArray,
            mobsArray: mobsArray,
            character: character,
            isEncounter: isEncounter,
            isShowing: isShowing,
            text: text,
            placeholder: placeholder,
            presenting: self,
            title: title,
            buttonLabel: buttonLable
        )
    }

}
