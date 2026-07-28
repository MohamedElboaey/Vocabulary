//
//  ScrambleQuiz.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 28/07/2026.
//


struct ScrambleQuiz: Identifiable {
    let id = UUID()
    let targetWord: Word
    let scrambledLetters: [Character]
}