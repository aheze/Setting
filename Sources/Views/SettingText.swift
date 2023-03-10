//
//  SettingText.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A simple text view.
 */
public struct SettingText: View, Setting {
    public var id: AnyHashable?
    public var title: String
    public var foregroundColor = SettingTheme.labelColor
    public var horizontalSpacing = CGFloat(12)
    public var verticalPadding = CGFloat(14)
    public var horizontalPadding = CGFloat(16)

    public init(
        id: AnyHashable? = nil,
        title: String,
        foregroundColor: Color = SettingTheme.labelColor,
        horizontalSpacing: CGFloat = CGFloat(12),
        verticalPadding: CGFloat = CGFloat(14),
        horizontalPadding: CGFloat = CGFloat(16)
    ) {
        self.id = id
        self.title = title
        self.foregroundColor = foregroundColor
        self.horizontalSpacing = horizontalSpacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
    }

    public var body: some View {
        SettingTextView(
            title: title,
            foregroundColor: foregroundColor,
            horizontalSpacing: horizontalSpacing,
            verticalPadding: verticalPadding,
            horizontalPadding: horizontalPadding
        )
    }
}

struct SettingTextView: View {
    let title: String
    var foregroundColor = SettingTheme.labelColor
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding = CGFloat(16)

    var body: some View {
        Text(title)
            .foregroundColor(foregroundColor)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
    }
}
