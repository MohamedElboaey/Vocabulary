
import Foundation

final class MockWordRepository: WordRepositoryProtocol {

    private var storage: [UUID: Word]
    private let queue = DispatchQueue(label: "MockWordRepository.storage")

    init() {
        var dict = [UUID: Word]()
        WordSeedData.all.forEach { dict[$0.id] = $0 }
        self.storage = dict
    }

    func fetchDeck(for level: LearningPace?, categories: Set<WordCategory>) -> [Word] {
        queue.sync { Array(storage.values).sorted { $0.term < $1.term } }
    }

    func updateMastery(wordID: UUID, to state: MasteryState) {
        queue.sync {
            storage[wordID]?.mastery = state
        }
    }
}
