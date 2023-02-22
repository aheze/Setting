//
//  Utilities.swift
//  SettingExample
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

extension Color {
    init(hex: Int, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
            opacity: alpha
        )
    }

    var hex: UInt {
        return getHex() ?? 0x00AEEF
    }

    /// from https://stackoverflow.com/a/28645384/14351818
    func getHex() -> UInt? {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0

        #if os(iOS)

            let color = UIColor(self)

            if color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
                fRed = fRed.clamped(to: 0 ... 1)
                fGreen = fGreen.clamped(to: 0 ... 1)
                fBlue = fBlue.clamped(to: 0 ... 1)

                let iRed = UInt(fRed * 255.0)
                let iGreen = UInt(fGreen * 255.0)
                let iBlue = UInt(fBlue * 255.0)

                //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
                let hex = (iRed << 16) + (iGreen << 8) + iBlue
                return hex
            } else {
                // Could not extract RGBA components:
                return nil
            }
        #else
            let color = NSColor(self)

            color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
            fRed = fRed.clamped(to: 0 ... 1)
            fGreen = fGreen.clamped(to: 0 ... 1)
            fBlue = fBlue.clamped(to: 0 ... 1)

            let iRed = UInt(fRed * 255.0)
            let iGreen = UInt(fGreen * 255.0)
            let iBlue = UInt(fBlue * 255.0)

            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let hex = (iRed << 16) + (iGreen << 8) + iBlue
            return hex

        #endif
    }
}

extension Comparable {
    /// used for the UIColor
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

public extension View {
    @inlinable
    func reverseMask<Mask: View>(
        padding: CGFloat = 0, /// extra negative padding for shadows
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask(
            Rectangle()
                .padding(-padding)
                .overlay(
                    mask()
                        .blendMode(.destinationOut)
                )
        )
    }
}
