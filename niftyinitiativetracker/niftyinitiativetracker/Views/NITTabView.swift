//
//  NITTabView.swift
//  niftyinitiativetracker
//
//  Created by Iiro Alhonen on 20.2.2022.
//

import SwiftUI

struct NITTabView: View {
    var body: some View {
        TabView {
            EncounterView()
                .tabItem {
                    VStack {
                        Image(systemName: "")
                        Text("Encounter")
                    }
                }
                .tag("Encounter")
        }
    }
}

struct NITTabView_Previews: PreviewProvider {
    static var previews: some View {
        NITTabView()
    }
}
