//
//  MainTabView.swift
//  DayMusic
//
//  Created by 최동호 on 8/27/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house")
                }
            AIView()
                .tabItem {
                    Label("AI추천", systemImage: "brain.head.profile")
                }
        }
        .tint(.primary)

    }
}
