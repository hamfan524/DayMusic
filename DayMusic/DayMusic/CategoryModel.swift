//
//  CategoryModel.swift
//  DayMusic
//
//  Created by 최동호 on 8/28/24.
//

import Foundation

struct CategoryModel: Identifiable {
    var id = UUID()
    var name: String
    var isRotated: Bool = false
    var extraOffset: CGFloat = 0.0
    var scale: CGFloat = 1.0
    var zIndex: Double = 0.0
}
