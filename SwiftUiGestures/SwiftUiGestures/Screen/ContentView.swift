//
//  ContentView.swift
//  SwiftUiGestures
//
//  Created by Gurjinder Singh on 04/10/22.
//

import SwiftUI

struct ContentView: View {
    // MAKE: - Property
    @State private var isAnimating: Bool = false
    @State private var imageScale: CGFloat = 1
    // MAKE: - Function
    // MAKE: - Content
    var body: some View {
        NavigationView {
            ZStack {
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .padding()
                    .shadow(color: .black.opacity(0.8), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 1), value: isAnimating)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()) {
                                imageScale = 5
                            }
                        } else {
                            withAnimation(.spring()) {
                                imageScale = 1
                            }
                        }
                    })
            }
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                    isAnimating = true
            }
        } // END of Navigation View
        //.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
