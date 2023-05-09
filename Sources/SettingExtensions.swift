//
//  SettingExtensions.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/22/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

extension Range<String.Index> {
    func attributedRange(for attributedString: AttributedString) -> Range<AttributedString.Index>? {
        let start = AttributedString.Index(lowerBound, within: attributedString)
        let end = AttributedString.Index(upperBound, within: attributedString)

        guard let start, let end else { return nil }
        let attributedRange = start ..< end
        return attributedRange
    }
}

/// From https://stackoverflow.com/a/32306142/14351818
extension StringProtocol {
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
              .range(of: string, options: options)
        {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

/**
 Read a view's size. The closure is called whenever the size itself changes.

 From https://stackoverflow.com/a/66822461/14351818
 */
extension View {
    func readSize(size: @escaping (CGSize) -> Void) -> some View {
        return background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: ContentSizeReaderPreferenceKey.self, value: geometry.size)
                    .onPreferenceChange(ContentSizeReaderPreferenceKey.self) { newValue in
                        DispatchQueue.main.async {
                            size(newValue)
                        }
                    }
            }
            .hidden()
        )
    }
}

struct ContentSizeReaderPreferenceKey: PreferenceKey {
    static var defaultValue: CGSize { return CGSize() }
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { value = nextValue() }
}
