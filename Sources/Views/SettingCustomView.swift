//
//  SettingCustomView.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A custom view for use inside `SettingPage` or `SettingGroup`.

 Tip: Wrap any `Setting` (such as `SettingText` or `SettingToggle`) inside here to further customize them.

     SettingCustomView {
         SettingText(title: "I'm bold!")
             .bold()
     }
 */
public struct SettingCustomView: Setting {
    /**
     A unique ID for identifying this view.

     This is highly recommended to prevent duplicate rendering issues.
     */
    public var id: AnyHashable?

    /**
     A title for indexing in the search results.
     */
    public var titleForSearch: String?

    /**
     Set to `false` to keep a grouped background.
     */
    public var displayIndependentlyInSearch = true

    /**
     The view to display.
     */
    public var view: AnyView

    public init<Content>(
        id: AnyHashable? = nil,
        titleForSearch: String? = nil,
        displayIndependentlyInSearch: Bool = true,
        @ViewBuilder view: () -> Content
    ) where Content: View {
        self.id = id
        self.titleForSearch = titleForSearch
        self.displayIndependentlyInSearch = displayIndependentlyInSearch
        self.view = AnyView(view())
    }
}
