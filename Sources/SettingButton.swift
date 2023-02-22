//
//  SettingButton.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

struct SettingButton: View, SettingItem {
    var id: AnyHashable?
    var title: String
    var indicator: String? = "arrow.up.forward"
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding = CGFloat(16)
    var action: () -> Void

    var body: some View {
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
