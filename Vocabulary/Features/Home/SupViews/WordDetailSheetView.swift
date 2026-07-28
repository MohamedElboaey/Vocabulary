//
//  WordDetailSheetView.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 25/07/2026.
//


import SwiftUI

/// Presented from the (i) button on the home feed. The card itself only
/// shows term/phonetic/definition (matching the reference app); part of
/// speech, the example sentence, synonyms, and difficulty live here so
/// they're not lost from the data model, just moved off the main card.
struct WordDetailSheetView: View {
    let word: Word

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Capsule()
                .fill(AppTheme.Colors.textSecondary.opacity(0.4))
                .frame(width: 40, height: 5)
                .frame(maxWidth: .infinity)
                .padding(.top, 10)

            HStack(alignment: .firstTextBaseline) {
                Text(word.term)
                    .font(AppTheme.Typography.title)
                    .foregroundStyle(AppTheme.Colors.textPrimary)
                Text(word.partOfSpeech)
                    .font(AppTheme.Typography.caption)
                    .italic()
                    .foregroundStyle(AppTheme.Colors.textSecondary)
                Spacer()
                Text(word.difficulty.label)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(AppTheme.Colors.textSecondary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(AppTheme.Colors.surface, in: Capsule())
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("EXAMPLE")
                    .font(.system(size: 11, weight: .bold))
                    .tracking(1)
                    .foregroundStyle(AppTheme.Colors.textSecondary)
                Text(word.example)
                    .font(AppTheme.Typography.body)
                    .italic()
                    .foregroundStyle(AppTheme.Colors.textPrimary)
            }

            if !word.synonyms.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("SYNONYMS")
                        .font(.system(size: 11, weight: .bold))
                        .tracking(1)
                        .foregroundStyle(AppTheme.Colors.textSecondary)
                    HStack(spacing: 8) {
                        ForEach(word.synonyms, id: \.self) { synonym in
                            Text(synonym)
                                .font(AppTheme.Typography.caption)
                                .foregroundStyle(AppTheme.Colors.textPrimary)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(AppTheme.Colors.surface, in: Capsule())
                        }
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .background(AppTheme.Colors.background.ignoresSafeArea())
    }
}