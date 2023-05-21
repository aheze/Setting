//
//  SettingSlider.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A slider.
 */
public struct SettingSlider: View, Setting {
    public var id: AnyHashable?
    @Binding public var value: Double
    public var range: ClosedRange<Double>
    public var step: Double.Stride = 0.1
    public var minimumImage: Image?
    public var maximumImage: Image?
    public var verticalPadding = CGFloat(8)
    public var horizontalPadding: CGFloat? = nil

    public init(
        id: AnyHashable? = nil,
        value: Binding<Double>,
        range: ClosedRange<Double>,
        step: Double.Stride = 0.1,
        minimumImage: Image? = nil,
        maximumImage: Image? = nil,
        verticalPadding: CGFloat = CGFloat(8),
        horizontalPadding: CGFloat? = nil
    ) {
        self.id = id
        self._value = value
        self.range = range
        self.step = step
        self.minimumImage = minimumImage
        self.maximumImage = maximumImage
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
    }

    public var body: some View {
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
    @Environment(\.edgePadding) var edgePadding
    
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double.Stride = 0.1
    var minimumImage: Image?
    var maximumImage: Image?
    var verticalPadding = CGFloat(8)
    var horizontalPadding: CGFloat? = nil

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
        .padding(.horizontal, horizontalPadding ?? edgePadding)
    }
}
