//
//  Settings.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

struct Settings: View {
    var body: some View {
        SettingStack {
            SettingPage(title: "Settings") {
                SettingGroup {
                    SettingPage(title: "General") {}
                        .previewIcon("gearshape.fill")
                }

                SettingGroup {
                    SettingPage(title: "Privacy") {}
                        .previewIcon("hand.raised.fill", color: .green)
                }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
