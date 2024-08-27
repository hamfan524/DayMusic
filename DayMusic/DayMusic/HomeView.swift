//
//  HomeView.swift
//  DayMusic
//
//  Created by 최동호 on 8/28/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    @Namespace var animationNamespace

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.black, .black, .black, .gray]),
                startPoint: .bottomLeading,
                endPoint: .top
            )
            .ignoresSafeArea()
            
            VStack {
                HStack(alignment: .firstTextBaseline) {
                    topTitle
                }
                
                Spacer()
                
                Spacer()
                
                CardView(cards: $viewModel.categories)
                    .frame(height: 220)
                    .padding(.horizontal,15)
                Spacer()
            }
        }
    }
    
    var topTitle: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("장르 선택")
            HStack {
                Text("선택한 장르에 맞춰서 매일 알림이 하나씩 가요")
                
            }
            Text("현재 선택한 장르")
                .foregroundStyle(.white)
                .contentTransition(.numericText())
        }
        .foregroundStyle(.white)
        .font(.largeTitle.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
