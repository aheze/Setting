//
//  SettingModifiers.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 5/8/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

extension View {
    func horizontalEdgePadding() -> some View {
        modifier(EdgePaddingModifier(edges: .horizontal))
    }
}

struct EdgePaddingModifier: ViewModifier {
    var edges: Edge.Set

    @Environment(\.edgePadding) var edgePadding

    func body(content: Content) -> some View {
        content
            .padding(edges, edgePadding)
    }
}
