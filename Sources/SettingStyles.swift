//
//  SettingStyles.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

public struct SettingRowButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
            .background {
                if configuration.isPressed {
                    Setting.labelColor
                        .opacity(0.1)
                }
            }
    }
}

public extension ButtonStyle where Self == SettingRowButtonStyle {
    static var row: SettingRowButtonStyle {
        SettingRowButtonStyle()
    }
}
