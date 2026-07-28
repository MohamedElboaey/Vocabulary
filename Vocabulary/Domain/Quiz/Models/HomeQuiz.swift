
import Foundation

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
