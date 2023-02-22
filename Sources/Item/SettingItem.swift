//
//  SettingItem.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 The base protocol for items shown in the `SettingBuilder`.
 */
public protocol SettingItem {
    var id: AnyHashable? { get set }
}

public extension SettingItem {
    /**
     A unique identifier for the view.
     */
    var identifier: AnyHashable {
        if let id {
            return id
        }

        return textIdentifier
    }

    /**
     The identifier generated from the item's title.
     */
    var textIdentifier: String? {
        switch self {
        case let text as SettingText:
            return text.title
        case let button as SettingButton:
            return button.title
        case let toggle as SettingToggle:
            return toggle.title
        case is SettingSlider:
            return nil
        case let picker as SettingPicker:
            return picker.title
        case let page as SettingPage:
            return page.title
        case let group as SettingGroup:
            return group.tuple.textIdentifier
        case let tuple as SettingTupleView:
            return tuple.flattened.compactMap { $0.textIdentifier }.joined()
        case let customView as SettingCustomView:
            return customView.titleForSearch ?? "Custom"
        default:
            print("Nil! \(type(of: self))")
            return nil
        }
    }

    /**
     Text for searching.
     */
    var text: String? {
        switch self {
        case let text as SettingText:
            return text.title
        case let button as SettingButton:
            return button.title
        case let toggle as SettingToggle:
            return toggle.title
        case is SettingSlider:
            return nil
        case let picker as SettingPicker:
            return picker.title
        case let page as SettingPage:
            return page.title
        case let group as SettingGroup:
            return group.header
        case is SettingTupleView:
            return nil
        case let customView as SettingCustomView:
            return customView.titleForSearch
        default:
            return nil
        }
    }
}

struct SettingItemView: View {
    var item: SettingItem
    var isInitialPage = false
    var isPagePreview = true

    @State var isActive = false

    var body: some View {
        switch item {
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
                        SettingItemView(item: page, isPagePreview: false)
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
                    ForEach(page.tuple.items, id: \.identifier) { item in
                        SettingItemView(item: item, isPagePreview: true)
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
                ForEach(group.tuple.items, id: \.identifier) { item in
                    SettingItemView(item: item)
                }
            }
        case let tuple as SettingTupleView:
            ForEach(tuple.items, id: \.identifier) { item in
                SettingItemView(item: item)
            }

        case let customView as SettingCustomView:
            customView.view
        default:
            Text("Unsupported item, please file a bug report.")
        }
    }
}
