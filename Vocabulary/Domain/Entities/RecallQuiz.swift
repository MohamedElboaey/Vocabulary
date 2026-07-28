
import Foundation

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

extension RecallQuiz: QuizBuilder {

    static func build(from session: LearningSession) -> RecallQuiz? {

        guard let target = session.recentWords.randomElement() else {
            return nil
        }

        let distractors = session.allWords
            .filter { $0.id != target.id }
            .shuffled()
            .prefix(2)

        var options = Array(distractors)
        options.append(target)
        options.shuffle()

        guard options.count >= 2 else {
            return nil
        }

        return RecallQuiz(
            targetWord: target,
            options: options
        )
    }
}
