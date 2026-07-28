import SwiftUI

struct WelcomeView: View {

    @State private var animateContent = false
    @State private var animateBackground = false

    var body: some View {

        ZStack {

            AppTheme.Colors.background
                    .ignoresSafeArea()

                RadialGradient(
                    colors: [
                        AppTheme.Colors.accent.opacity(0.18),
                        .clear
                    ],
                    center: .top,
                    startRadius: 20,
                    endRadius: 450
                )
                .ignoresSafeArea()


            VStack {

                Spacer()

                VStack(spacing: 28) {

                    ZStack {

                        Circle()
                            .fill(AppTheme.Colors.surface)
                            .frame(width: 110, height: 110)

                        Image(systemName: "book.pages.fill")
                            .font(.system(size: 44))
                            .foregroundStyle(AppTheme.Colors.accent)
                    }
                    .shadow(color: .black.opacity(0.12),
                            radius: 25,
                            y: 12)
                    .scaleEffect(animateContent ? 1.05 : 0.95)

                    VStack(spacing: 14) {

                        Text("Welcome to\nVocabulary")
                            .font(.system(
                                size: 42,
                                weight: .bold,
                                design: .serif
                            ))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(AppTheme.Colors.textPrimary)

                        Text("""
Learn beautiful English words.
Build a daily habit.
Become more confident.
""")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(AppTheme.Colors.textSecondary)

                    }
                    .offset(y: animateContent ? 0 : 24)

                }

                Spacer()
            }
            .padding(.horizontal, 32)

        }
        .animation(
            .easeInOut(duration: 3)
                .repeatForever(autoreverses: true),
            value: animateContent
        )
        .onAppear {
            withAnimation(
                .spring(response: 0.7,
                        dampingFraction: 0.75)
            ) {
                animateContent = true
            }
        }
    }
}
