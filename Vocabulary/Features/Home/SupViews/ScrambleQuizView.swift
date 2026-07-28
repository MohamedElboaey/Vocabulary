//
//  ScrambleQuizView.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 28/07/2026.
//


import SwiftUI

struct ScrambleQuizView: View {
    let quiz: ScrambleQuiz
    let onAnswer: (Word, Bool) -> Void
    let onDismiss: () -> Void

    @State private var placedIndices: [Int] = []
    @State private var revealed = false
    @State private var isCorrect = false

    var body: some View {
        VStack(spacing: 24) {
            Capsule()
                .fill(AppTheme.Colors.textSecondary.opacity(0.4))
                .frame(width: 40, height: 5)
                .padding(.top, 10)

            VStack(spacing: 8) {
                Image(systemName: "textformat.abc")
                    .font(.system(size: 28))
                    .foregroundStyle(AppTheme.Colors.accentSecondary)
                Text("Unscramble the word")
                    .font(AppTheme.Typography.title)
                    .foregroundStyle(AppTheme.Colors.textPrimary)
                Text(quiz.targetWord.definition)
                    .font(AppTheme.Typography.subheadline)
                    .foregroundStyle(AppTheme.Colors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
            }

            answerRow
            letterPool

            if revealed {
                resultBanner
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
        .animation(.easeInOut(duration: 0.15), value: placedIndices)
    }

    private var answerRow: some View {
        HStack(spacing: 8) {
            ForEach(quiz.scrambledLetters.indices, id: \.self) { slot in
                letterTile(
                    character: slot < placedIndices.count ? quiz.scrambledLetters[placedIndices[slot]] : nil,
                    isFilled: slot < placedIndices.count
                ) {
                    guard slot < placedIndices.count else { return }
                    removeFromSlot(slot)
                }
            }
        }
    }

    private var letterPool: some View {
        HStack(spacing: 8) {
            ForEach(quiz.scrambledLetters.indices, id: \.self) { index in
                if !placedIndices.contains(index) {
                    letterTile(character: quiz.scrambledLetters[index], isFilled: false) {
                        place(index)
                    }
                }
            }
        }
        .frame(minHeight: 52)
    }

    private func letterTile(character: Character?, isFilled: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(character.map { String($0).uppercased() } ?? "")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.Colors.textPrimary)
                .frame(width: 40, height: 48)
                .background(
                    isFilled ? AppTheme.Colors.accentSecondary.opacity(0.25) : AppTheme.Colors.surface,
                    in: RoundedRectangle(cornerRadius: 10, style: .continuous)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .strokeBorder(isFilled ? AppTheme.Colors.accentSecondary : .clear, lineWidth: 2)
                )
        }
        .buttonStyle(PressableButtonStyle())
        .disabled(revealed || character == nil)
    }

    private var resultBanner: some View {
        HStack(spacing: 8) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
            Text(isCorrect ? "Nice — that's right!" : "Not quite. It was \"\(quiz.targetWord.term)\".")
        }
        .font(AppTheme.Typography.subheadline)
        .foregroundStyle(isCorrect ? AppTheme.Colors.accentSecondary : AppTheme.Colors.danger)
    }

    private func place(_ index: Int) {
        guard !revealed, !placedIndices.contains(index) else { return }
        placedIndices.append(index)
        if placedIndices.count == quiz.scrambledLetters.count {
            check()
        }
    }

    private func removeFromSlot(_ slot: Int) {
        guard !revealed, placedIndices.indices.contains(slot) else { return }
        placedIndices.remove(at: slot)
    }

    private func check() {
        let attempt = String(placedIndices.map { quiz.scrambledLetters[$0] })
        isCorrect = attempt.caseInsensitiveCompare(quiz.targetWord.term) == .orderedSame
        revealed = true
        onAnswer(quiz.targetWord, isCorrect)
    }
}