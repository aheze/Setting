//
//  SettingTupleView.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

public struct SettingTupleView: SettingItem {
    public var id: AnyHashable?
    public var items: [SettingItem]
}

@resultBuilder public enum SettingBuilder {
    public static func buildOptional(_ component: SettingTupleView?) -> SettingTupleView {
        if let component {
            return SettingTupleView(items: [component])
        } else {
            return SettingTupleView(items: [])
        }
    }

    public static func buildBlock(_ parts: SettingItem...) -> SettingTupleView {
        return SettingTupleView(items: parts)
    }

    public static func buildEither(first component: SettingItem) -> SettingTupleView {
        return SettingTupleView(items: [component])
    }

    public static func buildEither(second component: SettingItem) -> SettingTupleView {
        return SettingTupleView(items: [component])
    }

    public static func buildArray(_ components: [SettingItem]) -> SettingTupleView {
        return SettingTupleView(items: components)
    }
}

public extension SettingTupleView {
    /// flatten the tuple view and groups
    var flattened: [SettingItem] {
        var flattened = [SettingItem]()

        for item in items {
            switch item {
            case let group as SettingGroup:
                flattened += group.tuple.flattened
            case let tuple as SettingTupleView:
                flattened += tuple.flattened
            default:
                flattened.append(item)
            }
        }

        return flattened
    }
}
