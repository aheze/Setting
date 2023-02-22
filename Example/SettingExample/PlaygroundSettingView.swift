//
//  PlaygroundSettingView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

struct PlaygroundSettingView: View {
    var body: some View {
        SettingStack {
            SettingPage(title: "Settings") {
                SettingGroup {
                    SettingPage(title: "Subsettings") {
                        SettingGroup {}
                    }
                    .previewIcon("star.fill")
                }
            }
        }
    }
}

struct PlaygroundSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundSettingView()
    }
}

class PlaygroundSettingViewModel: ObservableObject {}
