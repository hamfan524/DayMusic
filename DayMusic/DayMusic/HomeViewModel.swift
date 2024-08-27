//
//  HomeViewModel.swift
//  DayMusic
//
//  Created by 최동호 on 8/28/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var categories: [CategoryModel] = [
        .init(name: "전체"),
        .init(name: "발라드"),
        .init(name: "댄스"),
        .init(name: "R&B"),
        .init(name: "힙합"),
        .init(name: "락"),
        .init(name: "발라드"),
        .init(name: "팝송"),
        .init(name: "일본곡")
    ]
}
