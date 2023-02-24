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
    public var settings: [Setting]
}

/**
 The result builder for constructing `Setting` views.
 */
@resultBuilder public enum SettingBuilder {
    public static func buildOptional(_ component: SettingTupleView?) -> SettingTupleView {
        if let component {
            return SettingTupleView(settings: [component])
        } else {
            return SettingTupleView(settings: [])
        }
    }

    public static func buildBlock(_ parts: Setting...) -> SettingTupleView {
        return SettingTupleView(settings: parts)
    }

    public static func buildEither(first component: Setting) -> SettingTupleView {
        return SettingTupleView(settings: [component])
    }

    public static func buildEither(second component: Setting) -> SettingTupleView {
        return SettingTupleView(settings: [component])
    }

    public static func buildArray(_ components: [Setting]) -> SettingTupleView {
        return SettingTupleView(settings: components)
    }
}

public extension SettingTupleView {
    
    /// Flatten the tuple view and subgroups.
    var flattened: [Setting] {
        var flattened = [Setting]()

        for setting in settings {
            switch setting {
            case let group as SettingGroup:
                flattened += group.tuple.flattened
            case let tuple as SettingTupleView:
                flattened += tuple.flattened
            default:
                flattened.append(setting)
            }
        }

        return flattened
    }
}
