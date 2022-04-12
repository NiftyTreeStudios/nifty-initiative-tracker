//
//  TextFieldAlert.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 12.4.2022.
//

import SwiftUI

struct TextFieldAlert<Presenting>: View where Presenting: View {

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
                VStack {
                    Text(self.title)
                    TextField(placeholder, text: self.$text)
                    Divider()
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.isShowing.toggle()
                            }
                        }) {
                            buttonLabel
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.white)
                )
                .frame(
                    width: deviceSize.size.width*0.7,
                    height: deviceSize.size.height*0.7
                )
                .shadow(radius: 1)
                .opacity(self.isShowing ? 1 : 0)
            }
        }
    }

}
