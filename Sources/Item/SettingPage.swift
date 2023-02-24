//
//  SettingPage.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A settings page.
 */
public struct SettingPage: SettingItem {
    public var id: AnyHashable?
    public var title: String
    public var spacing = CGFloat(20)
    public var verticalPadding = CGFloat(6)
    public var backgroundColor = Setting.secondaryBackgroundColor
    public var navigationTitleDisplayMode = NavigationTitleDisplayMode.automatic
    public var previewConfiguration = PreviewConfiguration()
    @SettingBuilder public var tuple: SettingTupleView

    public init(
        id: AnyHashable? = nil,
        title: String,
        spacing: CGFloat = CGFloat(20),
        verticalPadding: CGFloat = CGFloat(6),
        backgroundColor: Color = Setting.secondaryBackgroundColor,
        navigationTitleDisplayMode: SettingPage.NavigationTitleDisplayMode = NavigationTitleDisplayMode.automatic,
        previewConfiguration: SettingPage.PreviewConfiguration = PreviewConfiguration(),
        @SettingBuilder tuple: () -> SettingTupleView
    ) {
        self.id = id
        self.title = title
        self.spacing = spacing
        self.verticalPadding = verticalPadding
        self.backgroundColor = backgroundColor
        self.navigationTitleDisplayMode = navigationTitleDisplayMode
        self.previewConfiguration = previewConfiguration
        self.tuple = tuple()
    }
    
    public var body: some View {
        Text("Hi")
    }

    public struct PreviewConfiguration {
        public var icon: SettingIcon?
        public var indicator = "chevron.forward"
        public var horizontalSpacing = CGFloat(12)
        public var verticalPadding = CGFloat(14)
        public var horizontalPadding = CGFloat(16)

        public init(
            icon: SettingIcon? = nil,
            indicator: String = "chevron.forward",
            horizontalSpacing: CGFloat = CGFloat(12),
            verticalPadding: CGFloat = CGFloat(14),
            horizontalPadding: CGFloat = CGFloat(16)
        ) {
            self.icon = icon
            self.indicator = indicator
            self.horizontalSpacing = horizontalSpacing
            self.verticalPadding = verticalPadding
            self.horizontalPadding = horizontalPadding
        }
    }

    public enum NavigationTitleDisplayMode {
        case automatic
        case inline
        case large
    }
}

/// Convenience modifiers.
public extension SettingPage {
    func previewIcon(_ icon: String, color: Color = .blue) -> SettingPage {
        var page = self
        page.previewConfiguration.icon = .system(icon: icon, backgroundColor: color)
        return page
    }

    func previewIcon(icon: SettingIcon) -> SettingPage {
        var page = self
        page.previewConfiguration.icon = icon
        return page
    }

    func previewIndicator(_ indicator: String) -> SettingPage {
        var page = self
        page.previewConfiguration.indicator = indicator
        return page
    }
}

struct SettingPageView<Content>: View where Content: View {
    var title: String
    var spacing = CGFloat(20)
    var verticalPadding = CGFloat(12)
    var backgroundColor = Setting.secondaryBackgroundColor
    var navigationTitleDisplayMode = SettingPage.NavigationTitleDisplayMode.inline
    var isInitialPage = false
    @ViewBuilder var content: Content

    var body: some View {
        #if os(iOS)

        let navigationBarTitleDisplayMode: NavigationBarItem.TitleDisplayMode = {
            switch navigationTitleDisplayMode {
            case .automatic:
                if isInitialPage {
                    return .large
                } else {
                    return .inline
                }
            case .inline:
                return .inline
            case .large:
                return .large
            }
        }()

        main
            .navigationBarTitleDisplayMode(navigationBarTitleDisplayMode)
        #else
        main
        #endif
    }

    @ViewBuilder var main: some View {
        if #available(iOS 16.0, *) {
            ScrollView {
                VStack(alignment: .leading, spacing: spacing) {
                    content
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, verticalPadding)
            }
            .scrollDismissesKeyboard(.interactively)
            .background(backgroundColor)
            .navigationTitle(title)
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: spacing) {
                    content
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, verticalPadding)
            }
            .background(backgroundColor)
            .navigationTitle(title)
        }
    }
}

struct SettingPagePreviewView: View {
    let title: String
    var icon: SettingIcon?
    var indicator = "chevron.forward"
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding = CGFloat(16)

    var body: some View {
        HStack(spacing: horizontalSpacing) {
            if let icon {
                SettingIconView(icon: icon)
            }

            Text(title)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, verticalPadding)

            Image(systemName: indicator)
                .foregroundColor(Setting.secondaryLabelColor)
        }
        .padding(.horizontal, horizontalPadding)
        .accessibilityElement(children: .combine)
    }
}

extension SettingPage {
    /// generate all possibile paths
    func generatePaths() -> [SettingPath] {
        var paths = [SettingPath]()

        for item in tuple.flattened {
            let initialItemPath = SettingPath(items: [item])
            let recursivePaths = generateRecursivePaths(for: initialItemPath)
            paths += recursivePaths
        }

        return paths
    }

    /// `path` - a path of rows whose last element is the row to generate
    func generateRecursivePaths(for path: SettingPath) -> [SettingPath] {
        /// include the current item as a path
        var paths = [path]

        /// get the last item, possibly a page
        guard let lastItem = path.items.last else { return [] }

        /// If the last item is a page, travel through the page's subpages.
        if let page = lastItem as? SettingPage {
            for item in page.tuple.flattened {
                /// If it's a subpage, generate paths for it.
                if let page = item as? SettingPage {
                    let currentPath = SettingPath(items: path.items + [page])
                    let recursivePaths = generateRecursivePaths(for: currentPath)
                    paths += recursivePaths
                } else {
                    /// If not, add the item as an endpoint.
                    let currentPath = SettingPath(items: path.items + [item])
                    paths += [currentPath]
                }
            }
        }

        return paths
    }
}
