//
//  PlaygroundView.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Setting
import SwiftUI

struct PlaygroundView: View {
    var body: some View {
        SettingStack {
            SettingPage(title: "Playground") {
                SettingCustomView {
                    Color.blue
                        .opacity(0.1)
                        .cornerRadius(12)
                        .overlay {
                            Text("Put anything here!")
                                .foregroundColor(.blue)
                                .font(.title.bold())
                        }
                        .frame(height: 150)
                        .padding(.horizontal, 16)
                }
            }
        }
    }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}
