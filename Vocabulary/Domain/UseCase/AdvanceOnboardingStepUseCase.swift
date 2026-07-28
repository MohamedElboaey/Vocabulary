//
//  AdvanceOnboardingStepUseCase.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 28/07/2026.
//


struct AdvanceOnboardingStepUseCase {

    func execute(
        current: OnboardingStep
    ) -> OnboardingStep {

        current.next ?? current
    }
}