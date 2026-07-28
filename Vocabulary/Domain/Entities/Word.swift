import Foundation

enum MasteryState: String, Codable {
    case new
    case learning
    case known
    case saved
}

struct Word: Identifiable, Codable, Equatable, Hashable {
    let id: UUID
    let term: String
    let phonetic: String
    let partOfSpeech: String
    let definition: String
    let example: String
    let synonyms: [String]
    let difficulty: Difficulty
    var mastery: MasteryState

    enum Difficulty: String, Codable, CaseIterable {
        case beginner, intermediate, advanced

        var label: String {
            switch self {
            case .beginner: "Beginner"
            case .intermediate: "Intermediate"
            case .advanced: "Advanced"
            }
        }
    }
}
