//
//  SettingDividedVStack.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A group of `Setting`s.
 */
public struct SettingGroup: Setting {
    public var id: AnyHashable?
    public var header: String?
    public var footer: String?
    public var horizontalPadding = CGFloat(16)
    public var backgroundColor = SettingTheme.backgroundColor
    public var backgroundCornerRadius = CGFloat(12)
    public var dividerLeadingMargin = CGFloat(16)
    public var dividerTrailingMargin = CGFloat(0)
    public var dividerColor: Color?
    @SettingBuilder public var tuple: SettingTupleView

    public init(
        id: AnyHashable? = nil,
        header: String? = nil,
        footer: String? = nil,
        horizontalPadding: CGFloat = CGFloat(16),
        backgroundColor: Color = SettingTheme.backgroundColor,
        backgroundCornerRadius: CGFloat = CGFloat(12),
        dividerLeadingMargin: CGFloat = CGFloat(16),
        dividerTrailingMargin: CGFloat = CGFloat(0),
        dividerColor: Color? = nil,
        @SettingBuilder tuple: () -> SettingTupleView
    ) {
        self.id = id
        self.header = header
        self.footer = footer
        self.horizontalPadding = horizontalPadding
        self.backgroundColor = backgroundColor
        self.backgroundCornerRadius = backgroundCornerRadius
        self.dividerLeadingMargin = dividerLeadingMargin
        self.dividerTrailingMargin = dividerTrailingMargin
        self.dividerColor = dividerColor
        self.tuple = tuple()
    }
}

struct SettingGroupView<Content: View>: View {
    var icon: SettingIcon?
    var header: String?
    var footer: String?
    var horizontalPadding = CGFloat(16)
    var backgroundColor = SettingTheme.backgroundColor
    var backgroundCornerRadius = CGFloat(12)
    var dividerLeadingMargin = CGFloat(16)
    var dividerTrailingMargin = CGFloat(0)
    var dividerColor: Color?
    @ViewBuilder var content: Content

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if icon != nil || header != nil {
                HStack(spacing: 2) {
                    if let icon {
                        SettingIconView(icon: icon)
                            .scaleEffect(0.6)
                    }

                    if let header {
                        Text(header)
                            .textCase(.uppercase)
                            .font(.system(.subheadline))
                            .foregroundColor(SettingTheme.secondaryLabelColor)
                    }
                }
                .padding(.horizontal, backgroundCornerRadius)
                .padding(.bottom, 6)
            }

            SettingDividedVStack(
                leadingMargin: dividerLeadingMargin,
                trailingMargin: dividerTrailingMargin,
                dividerColor: dividerColor
            ) {
                content
            }
            .background {
                if let backgroundColor {
                    backgroundColor
                }
            }
            .cornerRadius(backgroundCornerRadius)

            if let footer {
                Text(footer)
                    .font(.system(.subheadline))
                    .foregroundColor(SettingTheme.secondaryLabelColor)
                    .padding(.horizontal, backgroundCornerRadius)
                    .padding(.top, 8)
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
}
