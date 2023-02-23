//
//  ControlPanelView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

struct ControlPanelView: View {
    @State var volume = Double(8)
    @State var airplane = false
    @State var wifi = true
    @State var bluetooth = true

    var body: some View {
        SettingStack {
            SettingPage(title: "Control Panel") {
                SettingCustomView(id: "Controls") {
                    controls
                }

                SettingGroup(header: "Volume") {
                    SettingSlider(
                        value: $volume,
                        range: 0 ... 10,
                        minimumImage: Image(systemName: "speaker.fill"),
                        maximumImage: Image(systemName: "speaker.wave.3.fill")
                    )

                    SettingButton(title: "Export Data") {
                        print("Data Exported!")
                    }
                }

                let a = Binding {
                    airplane
                } set: { newValue in
                    airplane = newValue
                    if newValue {
                        wifi = false
                        bluetooth = false
                    }
                }

                let w = Binding {
                    wifi
                } set: { newValue in
                    wifi = newValue
                    if newValue {
                        airplane = false
                    }
                }
                let b = Binding {
                    bluetooth
                } set: { newValue in
                    bluetooth = newValue
                    if newValue {
                        airplane = false
                    }
                }

                SettingGroup {
                    SettingToggle(title: "Airplane Mode", isOn: a)
                    SettingToggle(title: "Wi-Fi", isOn: w)
                    SettingToggle(title: "Bluetooth", isOn: b)
                }
            }
        }
    }

    var controls: some View {
        VStack(spacing: 10) {
            ForEach(0..<2) { row in
                HStack(spacing: 10) {
                    ForEach(0..<4) { column in
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0.5),
                                Color.white.opacity(0.2),
                            ],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .cornerRadius(8)
                        .aspectRatio(1, contentMode: .fill)
                        .reverseMask {
                            Text("\(row * 4 + column + 1)")
                                .foregroundColor(.black)
                                .font(.title)
                                .bold()
                        }
                        .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 6)
                    }
                }
            }
        }
        .padding(16)
        .background(
            LinearGradient(
                colors: [
                    Color.orange,
                    Color.pink,
                ],
                startPoint: .bottomLeading,
                endPoint: .topTrailing
            )
        )
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}
