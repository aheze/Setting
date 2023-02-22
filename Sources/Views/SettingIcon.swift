//
//  SettingIcon.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

enum SettingIcon {
    case system(icon: String, backgroundColor: Color)
    case image(name: String, inset: CGFloat, backgroundColor: Color)
    case custom(view: AnyView)
}

struct SettingIconView: View {
    var icon: SettingIcon
    
    var body: some View {
        switch icon {
        case .system(let icon, let backgroundColor):
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.footnote)
                .frame(width: 28, height: 28)
                .background(backgroundColor)
                .cornerRadius(6)

        case .image(let name, let inset, let backgroundColor):
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(inset)
                .frame(width: 28, height: 28)
                .background(backgroundColor)
                .cornerRadius(6)

        case .custom(let anyView):
            anyView
        }
    }
}
