
import SwiftUI

struct RootView: View {
    @Binding var hasCompletedOnboarding: Bool
    @Binding var selectedVoiceID: String
    @Binding var selectedThemeID: String
    let fetchWordDeck: FetchWordDeckUseCase
    let updateWordMastery: UpdateWordMasteryUseCase

    @StateObject private var onboardingViewModel = OnboardingViewModel()

    var body: some View {
        Group {
            if hasCompletedOnboarding {
                HomeView(
                    viewModel: HomeViewModel(
                        fetchWordDeck: fetchWordDeck,
                        updateWordMastery: updateWordMastery,
                        voice: VoiceOption.resolve(id: selectedVoiceID),
                        theme: ReadingTheme(rawValue: selectedThemeID) ?? .autumnLeaves
                    )
                )
                .transition(.opacity)
            } else {
                OnboardingContainerView(
                    viewModel: onboardingViewModel,
                    onFinished: {
                        selectedVoiceID = onboardingViewModel.state.voice.id
                        selectedThemeID = onboardingViewModel.state.theme.rawValue
                        withAnimation(.easeInOut(duration: 0.35)) {
                            hasCompletedOnboarding = true
                        }
                    }
                )
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: hasCompletedOnboarding)
    }
}
