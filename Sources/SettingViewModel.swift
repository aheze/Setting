//
//  SettingViewModel.swift
//  Setting
//
//  Created by A. Zheng (github.com/aheze) on 2/21/23.
//  Copyright © 2023 A. Zheng. All rights reserved.
//

import Combine
import SwiftUI

class SettingViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResult: SettingSearchResult?

    @Published var paths = [SettingPath]()
    var regeneratePaths = PassthroughSubject<Void, Never>()
    var cancellables = Set<AnyCancellable>()

    init() {
        $searchText.sink { [weak self] searchText in
            guard let self else { return }
            self.processSearch(searchText: searchText)
        }
        .store(in: &cancellables)
    }
}

extension SettingViewModel {
    func processSearch(searchText: String) {
        if searchText.isEmpty {
            searchResult = nil
            return
        }

        let paths = self.paths

        DispatchQueue.global(qos: .userInitiated).async {
            let searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            var matchingPaths = [SettingPath]()

            for path in paths {
                guard let lastItem = path.items.last else { return }

                if let text = lastItem.text, text.localizedStandardContains(searchText) {
                    matchingPaths.append(path)
                }
            }

            var sections = [SettingSearchResult.Section]()

            for path in matchingPaths {
                /// should be the row in the main page
                guard let firstItem = path.items.first else { continue }

                if let firstPage = firstItem as? SettingPage {
                    if let firstIndex = sections.firstIndex(where: { $0.header == firstPage.title }) {
                        sections[firstIndex].paths.append(path)
                    } else {
                        let section = SettingSearchResult.Section(
                            icon: firstPage.previewConfiguration.icon,
                            header: firstPage.title,
                            paths: [path]
                        )
                        sections.append(section)
                    }
                } else {
                    let path = SettingPath(items: [firstItem])
                    let section = SettingSearchResult.Section(paths: [path])
                    sections.append(section)
                }
            }

            let searchResult = SettingSearchResult(sections: sections)

            DispatchQueue.main.async {
                self.searchResult = searchResult
            }
        }
    }
}
