//
//  HomeQuiz.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 28/07/2026.
//


enum HomeQuiz: Identifiable {
    case recall(RecallQuiz)
    case scramble(ScrambleQuiz)

    var id: UUID {
        switch self {
        case .recall(let quiz): quiz.id
        case .scramble(let quiz): quiz.id
        }
    }
}