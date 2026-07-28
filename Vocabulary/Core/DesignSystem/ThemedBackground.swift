import SwiftUI

/// Full-bleed background for a `ReadingTheme`. Video-loop themes render as
/// a gradient today (see `ReadingTheme.isVideoLoop`'s doc comment) with a
/// small looping-video glyph so the picker UI still communicates "this one
/// moves" — swapping in a real `AVPlayerLooper` later only touches this
/// file.
struct ThemedBackground: View {
    let theme: ReadingTheme

    var body: some View {
        ZStack {
            LinearGradient(colors: theme.previewColors, startPoint: .top, endPoint: .bottom)
            if theme.isVideoLoop {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(.white.opacity(0.55))
                            .padding(10)
                    }
                    Spacer()
                }
            }
        }
    }
}