//
//  HomeView.swift
//  DayMusic
//
//  Created by 최동호 on 8/28/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = HomeViewModel()

    @State private var scrollProgress: CGFloat = .zero
    @State private var tapState: AnimationState = .init()
    
    var opacity: CGFloat = 1.0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(spacing: 0) {
                TabView(selection: $viewModel.selectCategory) {
                    ForEach(viewModel.categories, id: \.rawValue) { tab in
                        TabImageView(tab)
                            .tag(tab)
                            .offsetX(viewModel.selectCategory.rawValue == tab.rawValue) { rect in
                                let minX = rect.minX
                                let pageOffset = minX - (size.width * CGFloat(tab.index))
                                let pageProgress = pageOffset / size.width
                                if !tapState.status {
                                    scrollProgress = max(min(pageProgress, 0), -CGFloat(CategoryModel.allCases.count - 1))
                                }
                            }
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .preferredColorScheme(.dark)
            .overlay(alignment: .top, content: {
                TabIndicatorView()
            })
            .ignoresSafeArea(.container, edges: .bottom)
        }
        .overlay {
            BorderAnimations(
                circleColor: .black,
                borderColor: .white,
                title: $viewModel.selectCategory,
                scrollProgress: $scrollProgress
            )
            .allowsHitTesting(false)
            .offset(y: 50)
        }
    }

    @ViewBuilder
    func TabIndicatorView() -> some View {
        GeometryReader {
            let size = $0.size
            let tabWidth = size.width / 3
            
            HStack(spacing: 0) {
                ForEach(CategoryModel.allCases, id: \.rawValue) { tab in
                    Text(tab.rawValue)
                        .font(.title3.bold())
                        .foregroundColor(viewModel.selectCategory.rawValue == tab.rawValue ? .primary : .gray)
                        .frame(width: tabWidth)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                viewModel.selectCategory = tab
                                scrollProgress = -CGFloat(tab.index)
                                tapState.startAnimation()
                            }
                        }
                }
            }
            .modifier(
                AnimationEndCallback(endValue: tapState.progress, onEnd: {
                    tapState.reset()
                })
            )
            .frame(width: CGFloat(CategoryModel.allCases.count) * tabWidth)
            .padding(.leading, tabWidth)
            .offset(x: scrollProgress * tabWidth)
        }
        .frame(height: 40)
        .padding(.top, 15)
        .background {
            Rectangle()
                .fill(.thinMaterial)
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func TabImageView(_ tab: CategoryModel) -> some View {
        GeometryReader {
            let size = $0.size
            Image(tab.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: size.height)
                .clipped()
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
}
