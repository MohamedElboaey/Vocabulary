
import Foundation

struct ScrambleQuiz: Identifiable {
    let id = UUID()
    let targetWord: Word
    let scrambledLetters: [Character]
}

extension ScrambleQuiz: QuizBuilder {

    static func build(from session: LearningSession) -> ScrambleQuiz? {

        guard let target = session.recentWords.randomElement() else {
            return nil
        }

        let original = Array(target.term.lowercased())
        var shuffled = original

        var attempts = 0

        while shuffled == original,
              original.count > 1,
              attempts < 10 {

            shuffled.shuffle()
            attempts += 1
        }

        return ScrambleQuiz(
            targetWord: target,
            scrambledLetters: shuffled
        )
    }
}
