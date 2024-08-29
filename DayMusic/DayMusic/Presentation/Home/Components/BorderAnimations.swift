//
//  BorderAnimations.swift
//  DayMusic
//
//  Created by 최동호 on 8/28/24.
//

import SwiftUI

struct BorderAnimations: View {
    var circleColor: Color
    var borderColor: Color
    @State var rotation: CGFloat = 0
    @Binding var title: CategoryModel
    @Binding var scrollProgress: CGFloat
    
    @State var opacity: CGFloat = 1.0
    
    var body: some View {
        ZStack{
            TransparentBlur(removeAllFilters: true)
                .blur(radius: 9, opaque: true)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(150)
                .frame(width: 260, height: 260)
                .foregroundStyle(circleColor)
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 10)
            
            Circle()
                .frame(width: 500 , height: 500)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [borderColor,
                                     borderColor.opacity(0.0),
                                     borderColor,
                                     borderColor.opacity(0.0),
                                     borderColor.opacity(0.0)]
                        ),
                        startPoint: .top,
                        endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    Circle()
                        .stroke(lineWidth: 3)
                        .frame(width: 257.5, height: 257.5)
                    
                }
            Text(title.rawValue).bold()
                .font(.largeTitle)
                .contentTransition(.numericText())
        }
        .frame(width: 260, height: 260)
        .onChange(of: title.rawValue) { title in
            opacity = 0.5
            withAnimation(.easeInOut(duration: 0.7)) {
                opacity = 1.0
            }
        }
        .opacity(opacity)
        .onAppear{
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)){
                rotation = 360
            }
        }
    }
}

