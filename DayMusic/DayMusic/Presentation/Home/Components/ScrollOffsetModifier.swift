//
//  ScrollOffsetModifier.swift
//  DayMusic
//
//  Created by 최동호 on 8/29/24.
//

import SwiftUI

struct ScrollOffset: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

/// Custom View Modifier Extension
extension View {
    @ViewBuilder
    func offsetX(_ addObserver: Bool = false, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                if addObserver {
                    GeometryReader {
                        let rect = $0.frame(in: .global)
                        
                        Color.clear
                            .preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self, perform: completion)
                    }
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
