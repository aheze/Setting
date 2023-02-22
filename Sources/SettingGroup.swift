//
//  SettingDividedVStack.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

struct SettingGroup: SettingItem {
    var id: AnyHashable?
    var header: String?
    var footer: String?
    var horizontalPadding = CGFloat(16)
    var backgroundColor = Setting.backgroundColor
    var backgroundCornerRadius = CGFloat(12)
    var dividerLeadingMargin = CGFloat(16)
    var dividerTrailingMargin = CGFloat(0)
    var dividerColor: Color?
    @SettingBuilder var tuple: SettingTupleView
}

struct SettingGroupView<Content: View>: View {
    var icon: SettingIcon?
    var header: String?
    var footer: String?
    var horizontalPadding = CGFloat(16)
    var backgroundColor = Setting.backgroundColor
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
                            .foregroundColor(Setting.secondaryLabelColor)
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
                    .foregroundColor(Setting.secondaryLabelColor)
                    .padding(.horizontal, backgroundCornerRadius)
                    .padding(.top, 8)
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
}
