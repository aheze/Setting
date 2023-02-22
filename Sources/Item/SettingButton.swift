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
public struct SettingButton: View, SettingItem {
    public var id: AnyHashable?
    public var title: String
    public var indicator: String? = "arrow.up.forward"
    public var horizontalSpacing = CGFloat(12)
    public var verticalPadding = CGFloat(14)
    public var horizontalPadding = CGFloat(16)
    public var action: () -> Void

    public init(
        id: AnyHashable? = nil,
        title: String,
        indicator: String? = "arrow.up.forward",
        horizontalSpacing: CGFloat = CGFloat(12),
        verticalPadding: CGFloat = CGFloat(14),
        horizontalPadding: CGFloat = CGFloat(16),
        action: @escaping () -> Void
    ) {
        self.id = id
        self.title = title
        self.indicator = indicator
        self.horizontalSpacing = horizontalSpacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.action = action
    }

    public var body: some View {
        SettingButtonView(
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
    let title: String
    var indicator: String? = "arrow.up.forward"
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding = CGFloat(16)
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: horizontalSpacing) {
                Text(title)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, verticalPadding)

                if let indicator {
                    Image(systemName: indicator)
                        .foregroundColor(Setting.secondaryLabelColor)
                }
            }
            .padding(.horizontal, horizontalPadding)
            .accessibilityElement(children: .combine)
        }
        .buttonStyle(.row)
    }
}
