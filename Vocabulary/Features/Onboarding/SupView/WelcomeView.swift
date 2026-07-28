import SwiftUI

struct WelcomeView: View {
    @State private var animateIn = false

    var body: some View {
        ZStack {
            ThemedBackground(theme: .forestCabin)
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.25))

            VStack(spacing: 20) {
                Spacer()

                Text("Welcome to Vocabulary")
                    .font(AppTheme.Typography.largeTitle)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .opacity(animateIn ? 1 : 0)
                    .offset(y: animateIn ? 0 : 12)

                Spacer()

                VStack(spacing: 6) {
                    Image(systemName: "chevron.up")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Swipe up")
                        .font(AppTheme.Typography.subheadline)
                }
                .foregroundStyle(.white.opacity(0.85))
                .opacity(animateIn ? 1 : 0)
                .padding(.bottom, 12)
            }
            .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.75).delay(0.05)) {
                animateIn = true
            }
        }
    }
}
