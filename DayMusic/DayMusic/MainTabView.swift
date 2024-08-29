//
//  MainTabView.swift
//  DayMusic
//
//  Created by 최동호 on 8/27/24.
//

import SwiftUI

struct MainTabView: View {
    @State var tempText: CategoryModel = .all
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("홈", systemImage: "house")
                }
            AIView()
                .tabItem {
                    Label("AI", systemImage: "brain.head.profile")
                }
            
            ZStack{
                Color.gray.opacity(0.3).ignoresSafeArea()
            }
                .tabItem {
                    Label("익명게시판", systemImage: "pencil.and.list.clipboard")
                }
            
            ZStack{
                Color.gray.opacity(0.3).ignoresSafeArea()
            }
                .tabItem {
                    Label("설정", systemImage: "gearshape.fill")
                }
            
        }
        .tint(.primary)
    }
}
