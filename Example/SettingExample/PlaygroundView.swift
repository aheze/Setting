//
//  PlaygroundView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

struct PlaygroundView: View {
    @AppStorage("index") var index = 0

    var body: some View {
        SettingStack {
            SettingPage(title: "Playground") {
                SettingGroup {
                    SettingPicker(
                        title: "Picker",
                        choices: ["A", "B", "C", "D"],
                        selectedIndex: $index
                    )
                }
            }
        }
    }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}
