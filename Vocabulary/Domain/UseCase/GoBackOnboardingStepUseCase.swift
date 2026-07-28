
import Foundation

struct GoBackOnboardingStepUseCase {

    func execute(
        current: OnboardingStep
    ) -> OnboardingStep {

        current.previous ?? current
    }
}
