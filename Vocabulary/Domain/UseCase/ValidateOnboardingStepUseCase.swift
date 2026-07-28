//
//  ValidateOnboardingStepUseCase.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 28/07/2026.
//


protocol ValidateOnboardingStepUseCase {

    func execute(
        step: OnboardingStep,
        state: OnboardingState
    ) -> Bool
}