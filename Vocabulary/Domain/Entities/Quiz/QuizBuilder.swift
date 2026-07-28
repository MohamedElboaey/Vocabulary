
import Foundation

protocol QuizBuilder {
    associatedtype Quiz

    static func build(from session: LearningSession) -> Quiz?
}
