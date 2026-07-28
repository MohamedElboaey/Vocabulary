import Foundation

protocol UpdateWordMasteryUseCase {
    func execute(wordID: UUID, to state: MasteryState)
}

struct DefaultUpdateWordMasteryUseCase: UpdateWordMasteryUseCase {
    private let repository: WordRepositoryProtocol

    init(repository: WordRepositoryProtocol) {
        self.repository = repository
    }

    func execute(wordID: UUID, to state: MasteryState) {
        repository.updateMastery(wordID: wordID, to: state)
    }
}
