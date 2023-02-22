//
//  SettingCustomView.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

struct SettingCustomView: SettingItem {
    var id: AnyHashable?
    var titleForSearch: String?
    var view: AnyView

    init<Content>(id: AnyHashable? = nil, titleForSearch: String? = nil, @ViewBuilder view: () -> Content) where Content: View {
        self.id = id
        self.titleForSearch = titleForSearch
        self.view = AnyView(view())
    }
}
