

import Foundation

struct AdvanceOnboardingStepUseCase {

    func execute(
        current: OnboardingStep
    ) -> OnboardingStep {

        current.next ?? current
    }
}
