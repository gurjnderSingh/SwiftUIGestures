//
//  ContentView.swift
//  SwiftUiGestures
//
//  Created by Gurjinder Singh on 04/10/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Property
    
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    @State private var shadowColor: Color = .black
    
    // MARK: - Content
    
    func resetSize() {
        withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .padding()
                    .shadow(color: shadowColor, radius: 22, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .offset(imageOffset)
                    .scaleEffect(imageScale)
                // MARK: - 1. Tap Gesture
                    .onTapGesture(count: 1, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            resetSize()
                        }
                    })
                // MARK: - 2. LongPress Gesture
                    .onLongPressGesture(perform: {
                        if shadowColor == .black {
                            shadowColor = .green
                        } else {
                            shadowColor = .black
                        }
                    })
                // MARK: - 3. Drag Gesture
                
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                imageOffset = gesture.translation
                            })
                            .onEnded({ _ in
                                if imageScale <= 1 {
                                    resetSize()
                                }
                            })
                    )
            }
            .ignoresSafeArea(edges: .all)
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                    isAnimating = true
            }
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                ,
            alignment: .top
            )
        } // END of Navigation View
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
