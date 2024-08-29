//
//  CategoryModel.swift
//  DayMusic
//
//  Created by 최동호 on 8/28/24.
//

enum CategoryModel: String, CaseIterable {
    case all = "All"
    case ballad = "Ballad"
    case acoustic = "Acoustic"
    case dance = "Dance"
    case rnb = "R&B"
    case hiphop = "Hiphop"
    case Rock = "Rock"
    case pop = "Pop"
    case japan = "J-Pop"
    
    var index: Int {
        return CategoryModel.allCases.firstIndex(of: self) ?? 0
    }
    
    var count: Int {
        return CategoryModel.allCases.count
    }
}
