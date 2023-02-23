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
            PreferencesView()
                .tabItem {
                    Label("Preferences", systemImage: "text.book.closed")
                }
                .tag(0)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(1)

            ControlPanelView()
                .tabItem {
                    Label("Control Panel", systemImage: "dial.high")
                }
                .tag(2)
            
            PlaygroundView()
                .tabItem {
                    Label("Playground", systemImage: "gamecontroller")
                }
                .tag(3)
        }
    }
}
