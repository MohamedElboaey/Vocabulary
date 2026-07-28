
import SwiftUI
import Combine

final class OnboardingViewModel: ObservableObject {

    @Published var state = OnboardingState()

    @Published private(set) var step: OnboardingStep = .welcome

    private let validator: ValidateOnboardingStepUseCaseProtocol
    private let nextStep: AdvanceOnboardingStepUseCase
    private let previousStep: GoBackOnboardingStepUseCase
    private let updateAppIcon: UpdateAppIconUseCaseProtocol
    private let skipStep: SkipOnboardingStepUseCaseProtocol
    
    var progress: Double {
        Double(step.rawValue + 1) / Double(OnboardingStep.allCases.count)
    }

    var isLastStep: Bool {
        step == .streak
    }
    
    var canAdvance: Bool {
        validator.execute(
            step: step,
            state: state
        )
    }
    
    var primaryButtonTitle: String {

        switch step {
        case .iconStyle:
            return "Change icon"
        case.theme:
            return "Change theme"
        case .voice:
            return "Save voice selection"
        case .streak:
            return "Get Started"

        default:
            return "Continue"
        }
    }
    
    init(state: OnboardingState = OnboardingState(), step: OnboardingStep = .welcome, validator: ValidateOnboardingStepUseCaseProtocol = DefaultValidateOnboardingStepUseCase(), nextStep: AdvanceOnboardingStepUseCase = AdvanceOnboardingStepUseCase(), previousStep: GoBackOnboardingStepUseCase = GoBackOnboardingStepUseCase(), updateAppIcon: UpdateAppIconUseCaseProtocol = DefaultUpdateAppIconUseCase(manager: AppIconManager()), skipStep: SkipOnboardingStepUseCaseProtocol = SkipOnboardingStepUseCase()) {
        self.state = state
        self.step = step
        self.validator = validator
        self.nextStep = nextStep
        self.previousStep = previousStep
        self.updateAppIcon = updateAppIcon
        self.skipStep = skipStep
    }

    func advance() {

        guard validator.execute(
            step: step,
            state: state
        ) else { return }

        HapticManager.shared.fire(.onboardingAdvance)

        withAnimation {
            step = nextStep.execute(current: step)
        }
    }
    
    func skip() {
        guard step.isSkippable else { return }

        HapticManager.shared.fire(.onboardingAdvance)

        withAnimation {
            step = skipStep.execute(current: step)
        }
    }

    func goBack() {
        withAnimation {
            step = previousStep.execute(current: step)
        }
    }

    // MARK: - Selection

    func selectTheme(_ theme: ReadingTheme) {
        HapticManager.shared.fire(.onboardingSelection)
        self.state.theme = theme
    }

    func selectVoice(_ voice: VoiceOption) {
        HapticManager.shared.fire(.onboardingSelection)
        self.state.voice = voice
    }

    func selectIcon(_ icon: AppIconStyle) {
        HapticManager.shared.fire(.onboardingSelection)
        self.state.iconStyle = icon
        updateAppIcon.execute(style: icon)
    }

    func selectAge(_ age: AgeRange) {
        HapticManager.shared.fire(.onboardingSelection)
        self.state.age = age
    }

    func selectGender(_ gender: Gender) {
        HapticManager.shared.fire(.onboardingSelection)
        self.state.gender = gender
    }

    func selectReferral(_ referral: ReferralSource) {
        HapticManager.shared.fire(.onboardingSelection)
        self.state.referral = referral
    }

    func selectLearningPace(_ pace: LearningPace) {
        HapticManager.shared.fire(.onboardingSelection)
        self.state.pace = pace
    }

    func selectHabitHelper(_ helper: HabitHelper) {
        HapticManager.shared.fire(.onboardingSelection)
        self.state.habitHelper = helper
    }
    
    func toggleCategory(_ category: WordCategory) {

        HapticManager.shared.fire(.onboardingSelection)

        if state.selectedCategories.contains(category) {
            state.selectedCategories.remove(category)
        } else {
            state.selectedCategories.insert(category)
        }
    }
}
