//
//  SettingSlider.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

struct SettingSlider: View, SettingItem {
    var id: AnyHashable?
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double.Stride = 1
    var minimumImage: Image?
    var maximumImage: Image?
    var verticalPadding = CGFloat(8)
    var horizontalPadding = CGFloat(16)

    var body: some View {
        SettingSliderView(
            value: $value,
            range: range,
            step: step,
            minimumImage: minimumImage,
            maximumImage: maximumImage,
            verticalPadding: verticalPadding,
            horizontalPadding: horizontalPadding
        )
    }
}

struct SettingSliderView: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double.Stride = 1
    var minimumImage: Image?
    var maximumImage: Image?
    var verticalPadding = CGFloat(8)
    var horizontalPadding = CGFloat(16)

    var body: some View {
        Slider(
            value: $value,
            in: range,
            step: step
        ) {
            EmptyView()
        } minimumValueLabel: {
            if let minimumImage {
                minimumImage
            }
        } maximumValueLabel: {
            if let maximumImage {
                maximumImage
            }
        }
        .accessibilityElement(children: .combine)
        .padding(.vertical, verticalPadding)
        .padding(.horizontal, horizontalPadding)
    }
}
