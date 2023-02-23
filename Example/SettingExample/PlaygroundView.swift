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
    @StateObject var settingViewModel = SettingViewModel()

    var body: some View {
        SettingStack(settingViewModel: settingViewModel) {
            SettingPage(title: "Playground") {
                SettingGroup {
                    SettingPicker(
                        title: "Picker",
                        choices: ["A", "B", "C", "D"],
                        selectedIndex: $index
                    )
                }
            }
        } customNoResultsView: {
            VStack(spacing: 20) {
                Image(systemName: "xmark")
                    .font(.largeTitle)

                Text("No results for '\(settingViewModel.searchText)'")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}
