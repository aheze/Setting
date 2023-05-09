//
//  SettingPicker.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import SwiftUI

/**
 A multi-choice picker.
 */
public struct SettingPicker: View, Setting {
    public var id: AnyHashable?
    public var icon: SettingIcon?
    public var title: String
    public var choices: [String]
    @Binding public var selectedIndex: Int
    public var foregroundColor: Color?
    public var horizontalSpacing = CGFloat(12)
    public var verticalPadding = CGFloat(14)
    public var horizontalPadding: CGFloat?
    public var choicesConfiguration = ChoicesConfiguration()

    public init(
        id: AnyHashable? = nil,
        icon: SettingIcon? = nil,
        title: String,
        choices: [String],
        selectedIndex: Binding<Int>,
        foregroundColor: Color? = nil,
        horizontalSpacing: CGFloat = CGFloat(12),
        verticalPadding: CGFloat = CGFloat(14),
        horizontalPadding: CGFloat? = nil,
        choicesConfiguration: ChoicesConfiguration = ChoicesConfiguration()
    ) {
        self.id = id
        self.icon = icon
        self.title = title
        self.choices = choices
        self._selectedIndex = selectedIndex
        self.foregroundColor = foregroundColor
        self.horizontalSpacing = horizontalSpacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.choicesConfiguration = choicesConfiguration
    }

    public enum PickerDisplayMode {
        case navigation
        case menu
        case inline
    }

    public struct ChoicesConfiguration {
        public var verticalPadding = CGFloat(14)
        public var horizontalPadding: CGFloat?
        public var pageNavigationTitleDisplayMode = SettingPage.NavigationTitleDisplayMode.inline
        public var pickerDisplayMode = PickerDisplayMode.navigation
        public var groupHeader: String?
        public var groupFooter: String?
        public var groupHorizontalPadding: CGFloat?
        public var groupBackgroundColor: Color?
        public var groupBackgroundCornerRadius = CGFloat(12)
        public var groupDividerLeadingMargin = CGFloat(16)
        public var groupDividerTrailingMargin = CGFloat(0)
        public var groupDividerColor: Color?

        public init(
            verticalPadding: CGFloat = CGFloat(14),
            horizontalPadding: CGFloat? = nil,
            pageNavigationTitleDisplayMode: SettingPage.NavigationTitleDisplayMode = SettingPage.NavigationTitleDisplayMode.inline,
            pickerDisplayMode: PickerDisplayMode = PickerDisplayMode.navigation,
            groupHeader: String? = nil,
            groupFooter: String? = nil,
            groupHorizontalPadding: CGFloat? = nil,
            groupBackgroundColor: Color? = nil,
            groupBackgroundCornerRadius: CGFloat = CGFloat(12),
            groupDividerLeadingMargin: CGFloat = CGFloat(16),
            groupDividerTrailingMargin: CGFloat = CGFloat(0),
            groupDividerColor: Color? = nil
        ) {
            self.verticalPadding = verticalPadding
            self.horizontalPadding = horizontalPadding
            self.pageNavigationTitleDisplayMode = pageNavigationTitleDisplayMode
            self.pickerDisplayMode = pickerDisplayMode
            self.groupHeader = groupHeader
            self.groupFooter = groupFooter
            self.groupHorizontalPadding = groupHorizontalPadding
            self.groupBackgroundColor = groupBackgroundColor
            self.groupBackgroundCornerRadius = groupBackgroundCornerRadius
            self.groupDividerLeadingMargin = groupDividerLeadingMargin
            self.groupDividerTrailingMargin = groupDividerTrailingMargin
            self.groupDividerColor = groupDividerColor
        }
    }

    public var body: some View {
        SettingPickerView(
            icon: icon,
            title: title,
            choices: choices,
            selectedIndex: $selectedIndex,
            foregroundColor: foregroundColor,
            horizontalSpacing: horizontalSpacing,
            verticalPadding: verticalPadding,
            horizontalPadding: horizontalPadding,
            choicesConfiguration: choicesConfiguration
        )
    }
}

/// Convenience modifiers.
public extension SettingPicker {
    func pickerDisplayMode(_ pickerDisplayMode: PickerDisplayMode) -> SettingPicker {
        var picker = self
        picker.choicesConfiguration.pickerDisplayMode = pickerDisplayMode
        return picker
    }
}

struct SettingPickerView: View {
    @Environment(\.edgePadding) var edgePadding
    @Environment(\.settingSecondaryColor) var settingSecondaryColor

    var icon: SettingIcon?
    let title: String
    var choices: [String]
    @Binding var selectedIndex: Int
    var foregroundColor: Color?
    var horizontalSpacing = CGFloat(12)
    var verticalPadding = CGFloat(14)
    var horizontalPadding: CGFloat? = nil
    var choicesConfiguration = SettingPicker.ChoicesConfiguration()

    @State var isActive = false

    var body: some View {
        switch choicesConfiguration.pickerDisplayMode {
        case .navigation:
            Button {
                isActive = true
            } label: {
                HStack(spacing: horizontalSpacing) {
                    if let icon {
                        SettingIconView(icon: icon)
                    }

                    Text(title)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, verticalPadding)

                    if choices.indices.contains(selectedIndex) {
                        let selectedChoice = choices[selectedIndex]

                        Text(selectedChoice)
                            .foregroundColor(foregroundColor ?? settingSecondaryColor)
                    }

                    Image(systemName: "chevron.forward")
                        .foregroundColor(foregroundColor ?? settingSecondaryColor)
                }
                .padding(.horizontal, horizontalPadding ?? edgePadding)
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

        case .menu:
            HStack(spacing: horizontalSpacing) {
                Text(title)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, verticalPadding)

                Picker("", selection: $selectedIndex) {
                    ForEach(Array(zip(choices.indices, choices)), id: \.1) { index, choice in
                        Text(choice).tag(index)
                    }
                }
                .pickerStyle(.menu)
                #if os(iOS)
                    .padding(.trailing, -edgePadding + 2)
                #else
                    .padding(.trailing, -2)
                #endif
                    .tint(foregroundColor ?? settingSecondaryColor)
            }
            .padding(.horizontal, horizontalPadding ?? edgePadding)
            .accessibilityElement(children: .combine)
        case .inline:
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
