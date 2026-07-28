import SwiftUI

/// Presented as a sheet after every `quizTriggerInterval` "known" swipes.
/// Fill-in-the-blank against the word's own example sentence — reuses
/// content already on the card, so it costs nothing extra to author words.
struct RecallQuizView: View {
    let quiz: RecallQuiz
    let onAnswer: (Word, Bool) -> Void
    let onDismiss: () -> Void

    @State private var selected: Word?
    @State private var revealed = false

    var body: some View {
        VStack(spacing: 24) {
            Capsule()
                .fill(AppTheme.Colors.textSecondary.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 10)

            VStack(spacing: 8) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 28))
                    .foregroundStyle(AppTheme.Colors.accentSecondary)
                Text("Quick recall check")
                    .font(AppTheme.Typography.title)
                    .foregroundStyle(AppTheme.Colors.textPrimary)
                Text("Fill in the blank")
                    .font(AppTheme.Typography.subheadline)
                    .foregroundStyle(AppTheme.Colors.textSecondary)
            }

            Text(quiz.promptSentence)
                .font(AppTheme.Typography.headline)
                .multilineTextAlignment(.center)
                .foregroundStyle(AppTheme.Colors.textPrimary)
                .padding(20)
                .background(AppTheme.Colors.surface, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                .padding(.horizontal, 8)

            VStack(spacing: 12) {
                ForEach(quiz.options) { option in
                    optionRow(option)
                }
            }

            if revealed {
                Button(action: onDismiss) {
                    Text("Continue")
                        .font(AppTheme.Typography.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(AppTheme.Colors.accent, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }

            Spacer(minLength: 0)
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .background(AppTheme.Colors.background.ignoresSafeArea())
        .animation(.easeInOut(duration: 0.2), value: revealed)
    }

    private func optionRow(_ option: Word) -> some View {
        let isCorrect = option.id == quiz.targetWord.id
        let isSelected = selected?.id == option.id

        return Button {
            guard !revealed else { return }
            selected = option
            revealed = true
            onAnswer(option, isCorrect)
        } label: {
            HStack {
                Text(option.term)
                    .font(AppTheme.Typography.body)
                    .foregroundStyle(AppTheme.Colors.textPrimary)
                Spacer()
                if revealed, isCorrect {
                    Image(systemName: "checkmark.circle.fill").foregroundStyle(AppTheme.Colors.accentSecondary)
                } else if revealed, isSelected {
                    Image(systemName: "xmark.circle.fill").foregroundStyle(AppTheme.Colors.danger)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(AppTheme.Colors.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .strokeBorder(borderColor(isCorrect: isCorrect, isSelected: isSelected), lineWidth: 2)
                    )
            )
        }
        .buttonStyle(PressableButtonStyle())
        .disabled(revealed)
    }

    private func borderColor(isCorrect: Bool, isSelected: Bool) -> Color {
        guard revealed else { return .clear }
        if isCorrect { return AppTheme.Colors.accentSecondary }
        if isSelected { return AppTheme.Colors.danger }
        return .clear
    }
}
