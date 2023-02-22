//
//  SettingDividedVStack.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/// A vertical stack that adds separators
/// From https://movingparts.io/variadic-views-in-swiftui
struct SettingDividedVStack<Content>: View where Content: View {
    var leadingMargin = CGFloat(0)
    var trailingMargin = CGFloat(0)
    var dividerColor: Color?
    @ViewBuilder var content: Content

    var body: some View {
        _VariadicView.Tree(
            SettingDividedVStackLayout(
                leadingMargin: leadingMargin,
                trailingMargin: trailingMargin,
                dividerColor: dividerColor
            )
        ) {
            content
        }
    }
}

struct SettingDividedVStackLayout: _VariadicView_UnaryViewRoot {
    var leadingMargin: CGFloat
    var trailingMargin: CGFloat
    var dividerColor: Color?

    @ViewBuilder func body(children: _VariadicView.Children) -> some View {
        let last = children.last?.id

        VStack(spacing: 0) {
            ForEach(children) { child in
                child

                if child.id != last {
                    Divider()
                        .opacity(dividerColor == nil ? 1 : 0)
                        .overlay {
                            if let dividerColor {
                                dividerColor
                            }
                        }
                        .padding(.leading, leadingMargin)
                        .padding(.trailing, trailingMargin)
                }
            }
        }
    }
}
