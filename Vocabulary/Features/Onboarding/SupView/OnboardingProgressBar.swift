
import SwiftUI

struct OnboardingProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule().fill(AppTheme.Colors.surface)
                Capsule()
                    .fill(AppTheme.Colors.accent)
                    .frame(width: proxy.size.width * progress)
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
        .frame(height: 6)
    }
}
