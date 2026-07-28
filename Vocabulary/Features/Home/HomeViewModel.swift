import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {

    @Published private(set) var state: HomeState
    @Published private(set) var words: [Word] = []
    @Published private(set) var currentIndex: Int = 0
    @Published private(set) var likedWordIDs: Set<UUID> = []
    @Published private(set) var savedWordIDs: Set<UUID> = []
    @Published var activeQuiz: HomeQuiz?

    let voice: VoiceOption
    let theme: ReadingTheme

    private let fetchWordDeck: FetchWordDeckUseCase
    private let updateWordMastery: UpdateWordMasteryUseCase
    private let userDefaults: UserDefaults
    private static let hasSeenIntroKey = "hasSeenHomeIntro"

    private let recallQuizInterval = 3
    private let scrambleQuizInterval = 4
    private let recentWordLimit = 4
    private var recentLikedWords: [Word] = []

    var currentWord: Word? { words.indices.contains(currentIndex) ? words[currentIndex] : nil }
    var progressLabel: String { "\(min(currentIndex + 1, max(words.count, 1)))/\(max(words.count, 1))" }
    var isCurrentWordLiked: Bool { currentWord.map { likedWordIDs.contains($0.id) } ?? false }
    var isCurrentWordSaved: Bool { currentWord.map { savedWordIDs.contains($0.id) } ?? false }
    var progress: Double {
        guard !words.isEmpty else { return 0 }
        return Double(currentIndex + 1) / Double(words.count)
    }

    init(
        fetchWordDeck: FetchWordDeckUseCase,
        updateWordMastery: UpdateWordMasteryUseCase,
        voice: VoiceOption,
        theme: ReadingTheme,
        userDefaults: UserDefaults = .standard
    ) {
        self.fetchWordDeck = fetchWordDeck
        self.updateWordMastery = updateWordMastery
        self.voice = voice
        self.theme = theme
        self.userDefaults = userDefaults
        self.state = userDefaults.bool(forKey: Self.hasSeenIntroKey) ? .word : .intro
        loadDeck()
    }

    func loadDeck() {
        words = fetchWordDeck.execute(level: nil, categories: [])
    }

    func dismissIntro() {
        guard state == .intro else { return }
        userDefaults.set(true, forKey: Self.hasSeenIntroKey)
        state = .word
    }

    func advance() {
        guard currentIndex < words.count - 1 else {
            words.append(contentsOf: fetchWordDeck.execute(level: nil, categories: []).shuffled())
            currentIndex += 1
            return
        }
        currentIndex += 1
    }

    func goBack() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }

    func toggleLike() {
        guard let word = currentWord else { return }
        if likedWordIDs.contains(word.id) {
            likedWordIDs.remove(word.id)
            HapticManager.shared.fire(.wordUnliked)
        } else {
            likedWordIDs.insert(word.id)
            updateWordMastery.execute(wordID: word.id, to: .known)
            HapticManager.shared.fire(.wordLiked)
            registerLike(word)
        }
    }

    func likeCurrentWord() {
        guard let word = currentWord, !likedWordIDs.contains(word.id) else { return }
        likedWordIDs.insert(word.id)
        updateWordMastery.execute(wordID: word.id, to: .known)
        HapticManager.shared.fire(.wordLiked)
        registerLike(word)
    }

    func toggleSave() {
        guard let word = currentWord else { return }
        if savedWordIDs.contains(word.id) {
            savedWordIDs.remove(word.id)
        } else {
            savedWordIDs.insert(word.id)
            updateWordMastery.execute(wordID: word.id, to: .saved)
            HapticManager.shared.fire(.wordSaved)
        }
    }

    func pronounceCurrentWord() {
        guard let word = currentWord else { return }
        SpeechService.shared.speak(word.term, voice: voice)
    }

    private func registerLike(_ word: Word) {

        recentLikedWords.append(word)

        if recentLikedWords.count > recentWordLimit {
            recentLikedWords.removeFirst()
        }

        let session = LearningSession(
            recentWords: recentLikedWords,
            allWords: words
        )

        activeQuiz = QuizEngine.makeQuiz(
            likeCount: likedWordIDs.count,
            session: session
        )
    }
    
    func submitQuizAnswer(_ word: Word, isCorrect: Bool) {
        HapticManager.shared.fire(isCorrect ? .quizCorrect : .quizIncorrect)
    }

    func dismissQuiz() {
        activeQuiz = nil
    }
}
