//
//  HomeViewModel.swift
//  DayMusic
//
//  Created by 최동호 on 8/28/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var selectCategory: CategoryModel = .all

    @Published var categories: [CategoryModel] = [
        .all,
        .ballad,
        .acoustic,
        .dance,
        .rnb,
        .hiphop,
        .Rock,
        .pop,
        .japan
    ]
}
