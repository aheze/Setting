//
//  SettingsView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

struct SettingsView: View {
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

                    SettingPage(title: "Notifications") {}
                        .previewIcon("bell.badge.fill", color: .red)
                }

                SettingGroup {
                    SettingPage(title: "Theme") {}
                        .previewIcon("paintbrush.fill", color: .purple)

                    SettingPage(title: "Widgets") {}
                        .previewIcon("square.grid.2x2.fill", color: .orange)
                    SettingPage(title: "About") {}
                        .previewIcon("person.fill", color: .teal)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

// struct Settings: View {
//    @State var isOn = false
//    @State var value = Double(50)
//
//    var body: some View {
//        SettingStack {
//            SettingPage(title: "Settings") {
//                SettingGroup {
//                    SettingPage(title: "General") {}
//                        .previewIcon("gearshape.fill")
//                }
//
//                SettingGroup {
//                    SettingPage(title: "Privacy") {}
//                        .previewIcon("hand.raised.fill", color: .green)
//
//                    SettingPage(title: "Notifications") {}
//                        .previewIcon("bell.badge.fill", color: .red)
//                }
//
//                SettingGroup {
//                    SettingToggle(title: "Advanced Settings", isOn: $isOn)
//                }
//
//                if isOn {
//                    SettingGroup(header: "Daily marketing emails") {
//                        SettingSlider(value: $value, range: 0 ... 100)
//                    }
//                }
//            }
//        }
//    }
// }
