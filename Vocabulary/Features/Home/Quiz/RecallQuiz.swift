//
//  RecallQuiz.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 28/07/2026.
//


struct RecallQuiz: Identifiable {
    let id = UUID()
    let targetWord: Word
    let options: [Word]
    
    var promptSentence: String {
        targetWord.example.replacingOccurrences(
            of: targetWord.term,
            with: "_____",
            options: .caseInsensitive
        )
    }
}