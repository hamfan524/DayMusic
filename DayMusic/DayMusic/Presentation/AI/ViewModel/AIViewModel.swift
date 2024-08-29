//
//  AIViewModel.swift
//  DayMusic
//
//  Created by 최동호 on 8/28/24.
//

import Combine
import Foundation

class AIViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var searchHistory: [String] = []
    @Published var isSearchFieldFocused: Bool = true

    private var cancellables = Set<AnyCancellable>()
    private let debounceDelay: TimeInterval = 0.5
}
