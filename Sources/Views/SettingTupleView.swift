//
//  SettingTupleView.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A `Setting` that can nest multiple sub-`Setting`s.
 */
public struct SettingTupleView: Setting {
    public var id: AnyHashable?
    public var items: [Setting]
}

/**
 The result builder for constructing `Setting` views.
 */
@resultBuilder public enum SettingBuilder {
    public static func buildOptional(_ component: SettingTupleView?) -> SettingTupleView {
        if let component {
            return SettingTupleView(items: [component])
        } else {
            return SettingTupleView(items: [])
        }
    }

    public static func buildBlock(_ parts: Setting...) -> SettingTupleView {
        return SettingTupleView(items: parts)
    }

    public static func buildEither(first component: Setting) -> SettingTupleView {
        return SettingTupleView(items: [component])
    }

    public static func buildEither(second component: Setting) -> SettingTupleView {
        return SettingTupleView(items: [component])
    }

    public static func buildArray(_ components: [Setting]) -> SettingTupleView {
        return SettingTupleView(items: components)
    }
}

public extension SettingTupleView {
    
    /// Flatten the tuple view and subgroups.
    var flattened: [Setting] {
        var flattened = [Setting]()

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
