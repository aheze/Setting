//
//  SettingEnvironment.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 4/28/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

private struct PrimaryColorKey: EnvironmentKey {
    static let defaultValue = Color.primary
}

private struct SecondaryColorKey: EnvironmentKey {
    static let defaultValue = Color.secondary
}

private struct AccentColorKey: EnvironmentKey {
    static let defaultValue = Color.accentColor
}

private struct BackgroundColorKey: EnvironmentKey {
    static let defaultValue: Color = {
        #if os(iOS)
            return Color(uiColor: .systemGroupedBackground)
        #else
            return Color(nsColor: .windowBackgroundColor)
        #endif
    }()
}

private struct SecondaryBackgroundColorKey: EnvironmentKey {
    static let defaultValue: Color = {
        #if os(iOS)
            return Color(uiColor: .secondarySystemGroupedBackground)
        #else
            return Color(nsColor: .textBackgroundColor)
        #endif
    }()
}

public extension EnvironmentValues {
    /// For text.
    var settingPrimaryColor: Color {
        get { self[PrimaryColorKey.self] }
        set { self[PrimaryColorKey.self] = newValue }
    }

    /// For secondary labels.
    var settingSecondaryColor: Color {
        get { self[SecondaryColorKey.self] }
        set { self[SecondaryColorKey.self] = newValue }
    }

    /// For buttons.
    var settingAccentColor: Color {
        get { self[AccentColorKey.self] }
        set { self[AccentColorKey.self] = newValue }
    }

    /// For outer views.
    var settingBackgroundColor: Color {
        get { self[BackgroundColorKey.self] }
        set { self[BackgroundColorKey.self] = newValue }
    }

    /// For inner views.
    var settingSecondaryBackgroundColor: Color {
        get { self[SecondaryBackgroundColorKey.self] }
        set { self[SecondaryBackgroundColorKey.self] = newValue }
    }
}
