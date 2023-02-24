//
//  SettingJumpLink.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A link to show in the search results, for jumping to specific page.
 */
public struct SettingJumpLink: View {
    public var path: SettingPath
    public var indicator = "chevron.forward"
    public var verticalSpacing = CGFloat(6)
    public var horizontalSpacing = CGFloat(12)
    public var verticalPadding = CGFloat(14)
    public var horizontalPadding = CGFloat(16)

    @EnvironmentObject var settingViewModel: SettingViewModel
    @State var isActive = false

    public init(
        path: SettingPath,
        indicator: String = "chevron.forward",
        verticalSpacing: CGFloat = CGFloat(6),
        horizontalSpacing: CGFloat = CGFloat(12),
        verticalPadding: CGFloat = CGFloat(14),
        horizontalPadding: CGFloat = CGFloat(16)
    ) {
        self.path = path
        self.indicator = indicator
        self.verticalSpacing = verticalSpacing
        self.horizontalSpacing = horizontalSpacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
    }

    public var body: some View {
        let destinationPage = path.items.last(where: { $0 is SettingPage })

        Button {
            isActive = true
        } label: {
            preview(destinationPage: destinationPage)
        }
        .buttonStyle(.row)
        .background {
            if let destinationPage {
                NavigationLink(isActive: $isActive) {
                    SettingView(item: destinationPage, isPagePreview: false)
                } label: {
                    EmptyView()
                }
                .opacity(0)
            }
        }
    }

    @ViewBuilder func preview(destinationPage: Setting?) -> some View {
        let title = getDestinationTitle()
        let titles = getPathTitles()

        HStack(spacing: horizontalSpacing) {
            VStack(spacing: verticalSpacing) {
                if settingViewModel.highlightMatchingText {
                    let highlightedText = highlightSearchText(searchText: settingViewModel.searchText, in: title)

                    Text(highlightedText)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text(title)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                /// only show titles if more than 1 (no need to say "General" underneath "General")
                if titles.count > 1 {
                    /// empty title
                    HStack(spacing: 2) {
                        ForEach(Array(zip(titles.indices, titles)), id: \.1.self) { index, title in
                            Text(title)

                            if index < titles.count - 1 {
                                Image(systemName: "arrow.right")
                            }
                        }
                    }
                    .font(.footnote)
                    .foregroundColor(SettingTheme.secondaryLabelColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.vertical, verticalPadding)

            if destinationPage != nil {
                Image(systemName: indicator)
                    .foregroundColor(SettingTheme.secondaryLabelColor)
            }
        }
        .padding(.horizontal, horizontalPadding)
        .accessibilityElement(children: .combine)
    }

    func getPathTitles() -> [String] {
        let titles = path.items.compactMap { $0.text }
        return titles
    }

    func getDestinationTitle() -> String {
        if
            let item = path.items.last,
            let title = item.text
        {
            return title
        }

        return ""
    }

    func highlightSearchText(searchText: String, in text: String) -> AttributedString {
        var attributedString = AttributedString(text)
        let ranges = text.ranges(of: searchText, options: [.caseInsensitive, .diacriticInsensitive])

        if ranges.isEmpty {
            attributedString.backgroundColor = .clear
        } else {
            attributedString.backgroundColor = .clear
            for range in ranges {
                if let attributedRange = range.attributedRange(for: attributedString) {
                    attributedString[attributedRange].backgroundColor = .accentColor.opacity(0.2)
                }
            }
        }

        return attributedString
    }
}
