import Foundation

/// Encapsulates "get the learner their next deck of words". Right now
/// this is a thin pass-through to the repository, but it's the seam where
/// real business rules land later — e.g. excluding words already marked
/// `.known` within the last N days, weighting by the onboarding-selected
/// `SkillLevel`/categories, or merging in a spaced-repetition ranking —
/// without HomeViewModel or the Data layer needing to know about any of it.
protocol FetchWordDeckUseCase {
    func execute(level: SkillLevel?, categories: Set<WordCategory>) -> [Word]
}

struct DefaultFetchWordDeckUseCase: FetchWordDeckUseCase {
    private let repository: WordRepositoryProtocol

    init(repository: WordRepositoryProtocol) {
        self.repository = repository
    }

    func execute(level: SkillLevel? = nil, categories: Set<WordCategory> = []) -> [Word] {
        repository.fetchDeck(for: level, categories: categories)
    }
}
