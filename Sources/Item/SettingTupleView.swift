//
//  SettingTupleView.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A `SettingItem` that can nest multiple sub-`SettingItem`s.
 */
public struct SettingTupleView: SettingItem {
    public var id: AnyHashable?
    public var items: [any SettingItem]

    public var body: some View {
        ForEach(items, id: \.identifier) { item in
//            item.body
            Text("Hi")
        }
    }
}

/**
 The result builder for constructing `SettingItem` views.
 */
@resultBuilder public enum SettingBuilder {
    public static func buildOptional(_ component: SettingTupleView?) -> SettingTupleView {
        if let component {
            return SettingTupleView(items: [component])
        } else {
            return SettingTupleView(items: [])
        }
    }

    public static func buildBlock(_ parts: any SettingItem...) -> SettingTupleView {
        return SettingTupleView(items: parts)
    }

    public static func buildEither(first component: any SettingItem) -> SettingTupleView {
        return SettingTupleView(items: [component])
    }

    public static func buildEither(second component: any SettingItem) -> SettingTupleView {
        return SettingTupleView(items: [component])
    }

    public static func buildArray(_ components: [any SettingItem]) -> SettingTupleView {
        return SettingTupleView(items: components)
    }
}

public extension SettingTupleView {
    /// Flatten the tuple view and subgroups.
    var flattened: [any SettingItem] {
        var flattened = [any SettingItem]()

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
