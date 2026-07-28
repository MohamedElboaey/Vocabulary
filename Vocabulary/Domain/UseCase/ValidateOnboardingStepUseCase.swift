
import Foundation

protocol ValidateOnboardingStepUseCaseProtocol {

    func execute(
        step: OnboardingStep,
        state: OnboardingState
    ) -> Bool
}


struct DefaultValidateOnboardingStepUseCase:
ValidateOnboardingStepUseCaseProtocol {

    func execute(
        step: OnboardingStep,
        state: OnboardingState
    ) -> Bool {

        switch step {

        case .welcome,
             .customizePrompt,
             .theme,
             .iconStyle,
             .voice,
             .streak:
            return true

        case .name:
            return !state.name
                .trimmingCharacters(in: .whitespaces)
                .isEmpty

        case .age:
            return state.age != nil

        case .gender:
            return state.gender != nil

        case .referral:
            return state.referral != nil

        case .pace:
            return state.pace != nil

        case .habitHelper:
            return state.habitHelper != nil

        case .topics:
            return !state.selectedCategories.isEmpty
        }
    }
}
