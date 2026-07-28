
import Foundation

protocol WordRepositoryProtocol {
    func fetchDeck(for level: LearningPace?, categories: Set<WordCategory>) -> [Word]
    func updateMastery(wordID: UUID, to state: MasteryState)
}
