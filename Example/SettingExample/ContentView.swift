//
//  ContentView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

struct ContentView: View {
    @AppStorage("selectedIndex") var selectedIndex = 1
    var body: some View {
        TabView(selection: $selectedIndex) {
            MainSettingView()
                .tabItem {
                    Label("Main", systemImage: "gearshape")
                }
                .tag(0)
            
            PlaygroundSettingView()
                .tabItem {
                    Label("Playground", systemImage: "gearshape")
                }
                .tag(1)
        }
    }
}
