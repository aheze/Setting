//
//  SettingSearchResult.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A struct containing the search results.
  */
public struct SettingSearchResult {
    public var sections: [Section]

    public struct Section: Identifiable {
        public let id = UUID()
        public var icon: SettingIcon?
        public var header: String?
        public var paths: [SettingPath]
    }
}

public struct SettingSearchResultView: View {
    @Environment(\.settingSecondaryBackgroundColor) var settingSecondaryBackgroundColor
    
    public var searchResult: SettingSearchResult
    public var spacing = CGFloat(20)
    public var verticalPadding = CGFloat(6)
    public var backgroundColor: Color?

    public init(
        searchResult: SettingSearchResult,
        spacing: CGFloat = CGFloat(20),
        verticalPadding: CGFloat = CGFloat(6),
        backgroundColor: Color? = nil
    ) {
        self.searchResult = searchResult
        self.spacing = spacing
        self.verticalPadding = verticalPadding
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing) {
                ForEach(searchResult.sections) { section in
                    content(section: section)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, verticalPadding)
        }
        .background(backgroundColor ?? settingSecondaryBackgroundColor)
    }

    @ViewBuilder func content(section: SettingSearchResult.Section) -> some View {
        /// If it's just a custom view on the first page, show the custom view as-is.
        if
            section.header == nil,
            let firstPath = section.paths.first,
            let firstItem = firstPath.settings.first,
            let setting = firstItem as? SettingCustomView,
            setting.displayIndependentlyInSearch
        {
            SettingView(setting: firstItem)
        } else {
            VStack {
                SettingGroupView(
                    icon: section.icon,
                    header: section.header
                ) {
                    ForEach(section.paths) { path in
                        /// If it's only 1 setting, the setting is on the main page - so just show it.
                        if path.settings.count == 1 {
                            if let setting = path.settings.first {
                                SettingView(setting: setting)
                            }
                        } else {
                            SettingJumpLink(path: path)
                        }
                    }
                }
            }
        }
    }
}
