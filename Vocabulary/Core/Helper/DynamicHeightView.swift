//
//  DynamicHeightView.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 28/07/2026.
//

import SwiftUI

struct DynamicHeightView<Content: View>: View {
    @Binding var height: CGFloat
    let content: Content

    init(height: Binding<CGFloat>,
         @ViewBuilder content: () -> Content) {
        _height = height
        self.content = content()
    }

    var body: some View {
        content
            .fixedSize(horizontal: false, vertical: true)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            height = proxy.size.height
                        }
                        .onChange(of: proxy.size.height) { _, newValue in
                            height = newValue
                        }
                }
            )
    }
}
