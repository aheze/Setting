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
    /// Settings supports `@State`, `@AppStorage`, `@Published`, and more!
    @AppStorage("isOn") var isOn = true

    var body: some View {
        /// Start things off with `SettingStack`.
        SettingStack {
            /// This is the main settings page.
            SettingPage(title: "Playground") {
                /// Use groups to group components together.
                SettingGroup(header: "Main Group") {
                    /// Use any of the pre-made components...
                    SettingToggle(title: "This value is persisted!", isOn: $isOn)

                    /// ...or define your own ones!

                    SettingCustomView {
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 160)
                            .padding(20)
                    }

                    /// Nest `SettingPage` inside other `SettingPage`s!
                    SettingPage(title: "Advanced Settings") {
                        SettingText(title: "I show up on the next page!")
                    }
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
