//
//  SettingPath.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A path for the search results.
 */
public struct SettingPath: Identifiable {
    public let id = UUID()
    public var items: [SettingItem]

    public init(items: [SettingItem]) {
        self.items = items
    }
}
