//
//  SettingSearchResult.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

struct SettingSearchResult {
    var sections: [Section]

    struct Section: Identifiable {
        let id = UUID()
        var icon: SettingIcon?
        var header: String?
        var paths: [SettingPath]
    }
}

struct SettingSearchResultView: View {
    var searchResult: SettingSearchResult
    var spacing = CGFloat(20)
    var verticalPadding = CGFloat(6)
    var backgroundColor = Setting.secondaryBackgroundColor

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: spacing) {
                ForEach(searchResult.sections) { section in
                    content(section: section)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, verticalPadding)
        }
        .background(backgroundColor)
    }

    @ViewBuilder func content(section: SettingSearchResult.Section) -> some View {
        /// If it's just a custom view on the first page, show the custom view as-is.
        if
            section.header == nil,
            let firstPath = section.paths.first,
            let firstItem = firstPath.items.first,
            firstItem is SettingCustomView
        {
            SettingItemView(item: firstItem)
        } else {
            VStack {
                SettingGroupView(
                    icon: section.icon,
                    header: section.header
                ) {
                    ForEach(section.paths) { path in
                        /// If it's only 1 item, the item is on the main page - so just show it.
                        if path.items.count == 1 {
                            if let item = path.items.first {
                                SettingItemView(item: item)
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
