import SwiftUI

struct CustomizePromptView: View {
    @State private var animateIn = false

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            Image(systemName: "slider.horizontal.3")
                .font(.system(size: 64, weight: .semibold))
                .foregroundStyle(AppTheme.Colors.accent)
                .scaleEffect(animateIn ? 1 : 0.7)
                .opacity(animateIn ? 1 : 0)

            Text("Customize the app to\nimprove your experience")
                .font(AppTheme.Typography.title)
                .multilineTextAlignment(.center)
                .foregroundStyle(AppTheme.Colors.textPrimary)
                .opacity(animateIn ? 1 : 0)
                .offset(y: animateIn ? 0 : 10)

            Spacer()
            Spacer()
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.75).delay(0.05)) {
                animateIn = true
            }
        }
    }
}
