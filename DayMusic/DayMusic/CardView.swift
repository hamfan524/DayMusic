//
//  CardView.swift
//  DayMusic
//
//  Created by 최동호 on 8/28/24.
//

import SwiftUI

struct CardView: View {
    @Binding var cards: [CategoryModel]
    
    @State var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            ZStack {
                ForEach(cards.reversed()) { card in
                    let index = indexOf(card: card)
                    
                    CardView(card: card, size: size)
                        .scaleEffect(card.scale,anchor: card.isRotated ? .center : .top)
                        .rotation3DEffect(.init(degrees: card.isRotated ? 360 : 0), axis: (x: 0, y: 0, z: 1))
                        .offset(y: -offsetFor(index: index))
                        .offset(y: card.extraOffset)
                        .scaleEffect(scaleFor(index: index), anchor: .top)
                        .zIndex(card.zIndex)
                        .offset(y: currentIndex == indexOf(card: card) ? offset : 0)
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: offset == .zero)
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 2)
                    .onChanged(onChanged(value:))
                    .onEnded(onEnded(value:))
            )
        }
    }
    
    @ViewBuilder
    func CardView(card: CategoryModel, size: CGSize) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 100, height: 50)
                .foregroundStyle(.gray)
            
            Text(card.name)
        }
        .frame(width: size.width, height: size.height)
        .blur(radius: card.isRotated ? 6.5 : 0)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    
    func onChanged(value: DragGesture.Value) {
        offset = currentIndex == (cards.count - 1) ? 0 : value.translation.height
    }
    
    func onEnded(value: DragGesture.Value) {
        var translation = value.translation.height
        
        translation = (translation < 0 ? -translation : 0)
        translation = (currentIndex == (cards.count - 1) ? 0 : translation)
        
        if translation > 110 {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                cards[currentIndex].isRotated = true
                cards[currentIndex].extraOffset = -350
                cards[currentIndex].scale = 0.7
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                    cards[currentIndex].zIndex = -100
                    for index in cards.indices {
                        cards[index].extraOffset = 0
                    }
                    
                    if currentIndex != (cards.count - 1) {
                        currentIndex += 1
                    }
                    offset = .zero
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                for index in cards.indices {
                    if index == currentIndex {
                        if cards.indices.contains(currentIndex - 1) {
                            cards[currentIndex - 1].zIndex = ZIndex(card: cards[currentIndex - 1])
                        }
                    } else {
                        cards[index].isRotated = false
                        withAnimation(.linear) {
                            cards[index].scale = 1
                        }
                    }
                }
                
                if currentIndex == (cards.count - 1) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        for index in cards.indices {
                            cards[index].zIndex = 0
                        }
                        currentIndex = 0
                    }
                }
            }
        } else {
            offset = .zero
        }
    }
    
    func ZIndex(card: CategoryModel) -> Double {
        let index = indexOf(card: card)
        let totalCount = cards.count
        
        return currentIndex > index ? Double(index - totalCount) : cards[index].zIndex
    }
    
    // MARK: Scale And Offset Values For Each Card
    func scaleFor(index value: Int) -> Double {
        let index = Double(value - currentIndex)
        if index >= 0 {
            if index > 3 {
                return 0.8
            }
            return 1 - (index / 15)
        } else {
            if -index > 3 {
                return 0.8
            }
            return 1 + (index / 15)
        }
    }
    
    func offsetFor(index value: Int) -> Double {
        let index = Double(value - currentIndex)
        if index >= 0 {
            if index > 3 {
                return 30
            }
            return (index * 10)
        } else {
            if -index > 3 {
                return 30
            }
            return (-index * 10)
        }
    }
    
    func indexOf(card: CategoryModel) -> Int {
        if let index = cards.firstIndex(where: { CCard in
            CCard.id == card.id
        }) {
            return index
        }
        return 0
    }
}
