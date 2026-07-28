
import SwiftUI

@main
struct VocabularyApp: App {

    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @AppStorage("selectedVoiceID") private var selectedVoiceID = VoiceOption.brian.id
    @AppStorage("selectedThemeID") private var selectedThemeID = ReadingTheme.autumnLeaves.rawValue

    private let wordRepository: WordRepositoryProtocol = MockWordRepository()

    private var fetchWordDeck: FetchWordDeckUseCase {
        DefaultFetchWordDeckUseCase(repository: wordRepository)
    }

    private var updateWordMastery: UpdateWordMasteryUseCase {
        DefaultUpdateWordMasteryUseCase(repository: wordRepository)
    }

    var body: some Scene {
        WindowGroup {
            RootView(
                hasCompletedOnboarding: $hasCompletedOnboarding,
                selectedVoiceID: $selectedVoiceID,
                selectedThemeID: $selectedThemeID,
                fetchWordDeck: fetchWordDeck,
                updateWordMastery: updateWordMastery
            )
            .preferredColorScheme(.dark)
        }
    }
}
