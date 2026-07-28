
import Foundation

protocol SkipOnboardingStepUseCaseProtocol {
    func execute(current: OnboardingStep) -> OnboardingStep
}

struct SkipOnboardingStepUseCase: SkipOnboardingStepUseCaseProtocol {

    private let nextStep = AdvanceOnboardingStepUseCase()

    func execute(current: OnboardingStep) -> OnboardingStep {
        nextStep.execute(current: current)
    }
}

