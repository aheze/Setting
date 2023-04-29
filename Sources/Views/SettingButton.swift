//
//  SettingButton.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A plain button.
 */
public struct SettingButton: View, Setting {
    public var id: AnyHashable?
    public var icon: SettingIcon?
    public var title: String
    public var indicator: String? = "arrow.up.forward"
    public var horizontalSpacing = CGFloat(12)
    public var verticalPadding = CGFloat(14)
    public var horizontalPadding = CGFloat(16)
    public var action: () -> Void

    public init(
        id: AnyHashable? = nil,
        icon: SettingIcon? = nil,
        title: String,
        indicator: String? = "arrow.up.forward",
        horizontalSpacing: CGFloat = CGFloat(12),
        verticalPadding: CGFloat = CGFloat(14),
        horizontalPadding: CGFloat = CGFloat(16),
        action: @escaping () -> Void
    ) {
        self.id = id
        self.icon = icon
        self.title = title
        self.indicator = indicator
        self.horizontalSpacing = horizontalSpacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.action = action
    }

    public var body: some View {
        SettingButtonView(
            icon: icon,
            title: title,
            indicator: indicator,
            horizontalSpacing: horizontalSpacing,
            verticalPadding: verticalPadding,
            horizontalPadding: horizontalPadding,
            action: action
        )
    }
}

struct SettingButtonView: View {
    @Environment(\.settingSecondaryColor) var settingSecondaryColor

    var icon: SettingIcon?
    let title: String
    var indicator: String? = "arrow.up.forward"
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding = CGFloat(16)
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: horizontalSpacing) {
                if let icon {
                    SettingIconView(icon: icon)
                }

                Text(title)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, verticalPadding)

                if let indicator {
                    Image(systemName: indicator)
                        .foregroundColor(settingSecondaryColor)
                }
            }
            .padding(.horizontal, horizontalPadding)
            .accessibilityElement(children: .combine)
        }
        .buttonStyle(.row)
    }
}

public extension SettingButton {
    func icon(_ icon: String, color: Color = .blue) -> SettingButton {
        var button = self
        button.icon = .system(icon: icon, backgroundColor: color)
        return button
    }

    func icon(_ icon: String, foregroundColor: Color = .white, backgroundColor: Color = .blue) -> SettingButton {
        var button = self
        button.icon = .system(icon: icon, foregroundColor: foregroundColor, backgroundColor: backgroundColor)
        return button
    }

    func icon(icon: SettingIcon) -> SettingButton {
        var button = self
        button.icon = icon
        return button
    }

    func indicator(_ indicator: String) -> SettingButton {
        var button = self
        button.indicator = indicator
        return button
    }
}
