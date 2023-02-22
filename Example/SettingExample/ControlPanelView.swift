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
    var body: some View {
        SettingStack {
            SettingPage(title: "Control Panel") {
                SettingCustomView(id: "Controls") {
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

                SettingGroup(header: "Volume") {
                    SettingSlider(
                        value: .constant(8),
                        range: 0 ... 10,
                        minimumImage: Image(systemName: "speaker.fill"),
                        maximumImage: Image(systemName: "speaker.wave.3.fill")
                    )

                    SettingButton(title: "Export Data") {
                        print("Data Exported!")
                    }
                }

                SettingGroup {
                    SettingToggle(title: "Airplane Mode", isOn: .constant(false))
                    SettingToggle(title: "Wi-Fi", isOn: .constant(true))
                    SettingToggle(title: "Bluetooth", isOn: .constant(true))
                }
            }
        }
    }
}
