
import Foundation

struct QuizEngine {

    static func makeQuiz(
        likeCount: Int,
        session: LearningSession
    ) -> HomeQuiz? {

        switch likeCount {

        case let count where count % 4 == 0:
            if let quiz = ScrambleQuiz.build(from: session) {
                return .scramble(quiz)
            }

        case let count where count % 3 == 0:
            if let quiz = RecallQuiz.build(from: session) {
                return .recall(quiz)
            }

        default:
            return nil
        }

        return nil
    }
}
