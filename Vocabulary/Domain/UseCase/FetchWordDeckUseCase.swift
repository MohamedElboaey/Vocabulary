import Foundation

protocol FetchWordDeckUseCase {
    func execute(level: LearningPace?, categories: Set<WordCategory>) -> [Word]
}

struct DefaultFetchWordDeckUseCase: FetchWordDeckUseCase {
    private let repository: WordRepositoryProtocol

    init(repository: WordRepositoryProtocol) {
        self.repository = repository
    }

    func execute(level: LearningPace? = nil, categories: Set<WordCategory> = []) -> [Word] {
        repository.fetchDeck(for: level, categories: categories)
    }
}
