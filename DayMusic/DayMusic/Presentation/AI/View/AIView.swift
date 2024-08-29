//
//  AIView.swift
//  DayMusic
//
//  Created by 최동호 on 8/27/24.
//

import SwiftUI

struct AIView: View {
    @StateObject var viewModel = AIViewModel()
    
    var body: some View {
        NavigationStack {
            if #available(iOS 17.0, *) {
                SongSearch
                    .searchable(text: $viewModel.searchText, isPresented: $viewModel.isSearchFieldFocused, placement: .navigationBarDrawer(displayMode: .always), prompt: "노래 검색")
            } else {
                SongSearch
                    .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "노래 검색")
            }
        }
    }
    
    @ViewBuilder
    private var SongSearch: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationTitle("노래 검색")
        .navigationBarTitleDisplayMode(.inline)
    }
}
