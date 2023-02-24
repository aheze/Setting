//
//  SettingView.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    var setting: Setting
    var isInitialPage = false
    var isPagePreview = true

    @State var isActive = false

    var body: some View {
        switch setting {
        case let text as SettingText:
            text
        case let button as SettingButton:
            button
        case let toggle as SettingToggle:
            toggle
        case let slider as SettingSlider:
            slider
        case let picker as SettingPicker:
            picker
        case let page as SettingPage:

            if isPagePreview {
                Button {
                    isActive = true
                } label: {
                    SettingPagePreviewView(
                        title: page.title,
                        icon: page.previewConfiguration.icon,
                        indicator: page.previewConfiguration.indicator,
                        horizontalSpacing: page.previewConfiguration.horizontalSpacing,
                        verticalPadding: page.previewConfiguration.verticalPadding,
                        horizontalPadding: page.previewConfiguration.horizontalPadding
                    )
                }
                .buttonStyle(.row)
                .background {
                    NavigationLink(isActive: $isActive) {
                        SettingView(setting: page, isPagePreview: false)
                    } label: {
                        EmptyView()
                    }
                    .opacity(0)
                }

            } else {
                SettingPageView(
                    title: page.title,
                    spacing: page.spacing,
                    verticalPadding: page.verticalPadding,
                    backgroundColor: page.backgroundColor,
                    navigationTitleDisplayMode: page.navigationTitleDisplayMode,
                    isInitialPage: isInitialPage
                ) {
                    ForEach(page.tuple.settings, id: \.identifier) { setting in
                        SettingView(setting: setting, isPagePreview: true)
                    }
                }
            }
        case let group as SettingGroup:
            SettingGroupView(
                header: group.header,
                footer: group.footer,
                horizontalPadding: group.horizontalPadding,
                backgroundColor: group.backgroundColor,
                backgroundCornerRadius: group.backgroundCornerRadius,
                dividerLeadingMargin: group.dividerLeadingMargin,
                dividerTrailingMargin: group.dividerTrailingMargin,
                dividerColor: group.dividerColor
            ) {
                ForEach(group.tuple.settings, id: \.identifier) { setting in
                    SettingView(setting: setting)
                }
            }
        case let tuple as SettingTupleView:
            ForEach(tuple.settings, id: \.identifier) { setting in
                SettingView(setting: setting)
            }

        case let customView as SettingCustomView:
            customView.view
        default:
            Text("Unsupported setting, please file a bug report.")
        }
    }
}
