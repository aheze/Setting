//
//  SettingStack.swift
//  Setting
//
//  Created by Zheng on 2/21/23.
//

import SwiftUI

struct SettingStack: View {
    var page: () -> SettingPage

    @StateObject var settingViewModel = SettingViewModel()

    var body: some View {
        if #available(iOS 16.0, macOS 13.0, *) {
            NavigationStack {
                main
            }
        } else {
            NavigationView {
                main
            }
        }
    }

    @ViewBuilder var main: some View {
        let settingPage = page()

        VStack {
            if settingViewModel.searchText.isEmpty {
                SettingItemView(item: settingPage, isPagePreview: false)
            } else if
                let searchResult = settingViewModel.searchResult,
                !searchResult.sections.isEmpty
            {
                SettingSearchResultView(searchResult: searchResult)
            } else {
                Text("No results for '\(settingViewModel.searchText)'")
                    .foregroundColor(Setting.secondaryLabelColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Setting.secondaryBackgroundColor)
            }
        }
        .searchable(text: $settingViewModel.searchText)
        .environmentObject(settingViewModel)
        .onAppear {
            let paths = settingPage.generatePaths()
            settingViewModel.paths = paths
        }
        .onReceive(settingViewModel.regeneratePaths) { _ in
            let paths = settingPage.generatePaths()
            settingViewModel.paths = paths
        }
    }
}
