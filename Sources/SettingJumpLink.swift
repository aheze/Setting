//
//  SettingJumpLink.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

struct SettingJumpLink: View {
    var path: SettingPath
    var indicator = "chevron.forward"
    var verticalSpacing = CGFloat(6)
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding = CGFloat(16)

    @EnvironmentObject var settingsViewModel: SettingViewModel
    @State var isActive = false

    var body: some View {
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
                    SettingItemView(item: destinationPage, isPagePreview: false)
                } label: {
                    EmptyView()
                }
                .opacity(0)
            }
        }
    }

    @ViewBuilder func preview(destinationPage: SettingItem?) -> some View {
        let title = getDestinationTitle()
        let titles = getPathTitles()

        HStack(spacing: horizontalSpacing) {
            VStack(spacing: verticalSpacing) {
                Text(title)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)

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
                    .foregroundColor(Setting.secondaryLabelColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.vertical, verticalPadding)

            if destinationPage != nil {
                Image(systemName: indicator)
                    .foregroundColor(Setting.secondaryLabelColor)
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
}
