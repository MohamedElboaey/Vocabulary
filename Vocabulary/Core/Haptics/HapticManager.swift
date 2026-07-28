
import UIKit

final class HapticManager {

    static let shared = HapticManager()

    private let lightImpact = UIImpactFeedbackGenerator(style: .light)
    private let mediumImpact = UIImpactFeedbackGenerator(style: .medium)
    private let rigidImpact = UIImpactFeedbackGenerator(style: .rigid)
    private let softImpact = UIImpactFeedbackGenerator(style: .soft)
    private let notification = UINotificationFeedbackGenerator()
    private let selection = UISelectionFeedbackGenerator()

    private init() {
        prepareAll()
    }

    private func prepareAll() {
        [lightImpact, mediumImpact, rigidImpact, softImpact].forEach { $0.prepare() }
        notification.prepare()
        selection.prepare()
    }

    enum Event {
        case feedTransitionStarted     // soft tick the moment a vertical drag begins
        case feedTransitionCommitted   // rigid pulse the instant the swipe becomes committable
        case wordLiked                 // success notification – word marked "known" via heart
        case wordUnliked               // light tap – heart un-tapped
        case wordSaved                 // distinct double-tap feel for bookmarking
        case onboardingSelection       // light selection tick for pickers
        case onboardingAdvance         // medium impact for "Continue" taps
        case voicePreview              // light tap when previewing a voice sample
        case quizCorrect
        case quizIncorrect
    }

    func fire(_ event: Event) {
        switch event {
        case .feedTransitionStarted:
            softImpact.impactOccurred(intensity: 0.5)
        case .feedTransitionCommitted:
            rigidImpact.impactOccurred(intensity: 0.9)
        case .wordLiked:
            notification.notificationOccurred(.success)
        case .wordUnliked:
            lightImpact.impactOccurred(intensity: 0.5)
        case .wordSaved:
            lightImpact.impactOccurred(intensity: 0.6)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) { [weak self] in
                self?.lightImpact.impactOccurred(intensity: 0.9)
            }
        case .onboardingSelection:
            selection.selectionChanged()
        case .onboardingAdvance:
            mediumImpact.impactOccurred(intensity: 0.8)
        case .voicePreview:
            lightImpact.impactOccurred(intensity: 0.7)
        case .quizCorrect:
            notification.notificationOccurred(.success)
        case .quizIncorrect:
            notification.notificationOccurred(.error)
        }
        prepareAll()
    }
}
