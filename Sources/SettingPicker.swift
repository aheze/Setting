//
//  SettingPicker.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

struct SettingPicker: View, SettingItem {
    var id: AnyHashable?
    var title: String
    var choices: [String]
    @Binding var selectedIndex: Int
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding = CGFloat(16)
    var choicesConfiguration = ChoicesConfiguration()

    struct ChoicesConfiguration {
        var verticalPadding = CGFloat(14)
        var horizontalPadding = CGFloat(16)
        var pageNavigationTitleDisplayMode = SettingPage.NavigationTitleDisplayMode.inline
        var groupHeader: String?
        var groupFooter: String?
        var groupHorizontalPadding = CGFloat(16)
        var groupBackgroundColor = Setting.backgroundColor
        var groupBackgroundCornerRadius = CGFloat(12)
        var groupDividerLeadingMargin = CGFloat(16)
        var groupDividerTrailingMargin = CGFloat(0)
        var groupDividerColor: Color?
    }

    var body: some View {
        SettingPickerView(
            title: title,
            choices: choices,
            selectedIndex: $selectedIndex,
            horizontalSpacing: horizontalSpacing,
            verticalPadding: verticalPadding,
            horizontalPadding: horizontalPadding,
            choicesConfiguration: choicesConfiguration
        )
    }
}

struct SettingPickerView: View {
    let title: String
    var choices: [String]
    @Binding var selectedIndex: Int
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding = CGFloat(16)
    var choicesConfiguration = SettingPicker.ChoicesConfiguration()

    @State var isActive = false

    var body: some View {
        Button {
            isActive = true
        } label: {
            HStack(spacing: horizontalSpacing) {
                Text(title)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, verticalPadding)

                if choices.indices.contains(selectedIndex) {
                    let selectedChoice = choices[selectedIndex]

                    Text(selectedChoice)
                        .foregroundColor(Setting.secondaryLabelColor)
                }

                Image(systemName: "chevron.forward")
                    .foregroundColor(Setting.secondaryLabelColor)
            }
            .padding(.horizontal, horizontalPadding)
            .accessibilityElement(children: .combine)
        }
        .buttonStyle(.row)
        .background {
            NavigationLink(isActive: $isActive) {
                SettingPickerChoicesView(
                    title: title,
                    choices: choices,
                    selectedIndex: $selectedIndex,
                    choicesConfiguration: choicesConfiguration
                )
            } label: {
                EmptyView()
            }
            .opacity(0)
        }
    }
}

struct SettingPickerChoicesView: View {
    let title: String
    var choices: [String]
    @Binding var selectedIndex: Int
    var choicesConfiguration: SettingPicker.ChoicesConfiguration

    var body: some View {
        SettingPageView(title: title, navigationTitleDisplayMode: choicesConfiguration.pageNavigationTitleDisplayMode) {
            SettingGroupView(
                header: choicesConfiguration.groupHeader,
                footer: choicesConfiguration.groupFooter,
                horizontalPadding: choicesConfiguration.groupHorizontalPadding,
                backgroundColor: choicesConfiguration.groupBackgroundColor,
                backgroundCornerRadius: choicesConfiguration.groupBackgroundCornerRadius,
                dividerLeadingMargin: choicesConfiguration.groupDividerLeadingMargin,
                dividerTrailingMargin: choicesConfiguration.groupDividerTrailingMargin,
                dividerColor: choicesConfiguration.groupDividerColor
            ) {
                ForEach(Array(zip(choices.indices, choices)), id: \.1) { index, choice in
                    Button {
                        selectedIndex = index
                    } label: {
                        HStack {
                            Text(choice)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, choicesConfiguration.verticalPadding)

                            if index == selectedIndex {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                        .padding(.horizontal, choicesConfiguration.horizontalPadding)
                    }
                    .buttonStyle(.row)
                }
            }
        }
    }
}
