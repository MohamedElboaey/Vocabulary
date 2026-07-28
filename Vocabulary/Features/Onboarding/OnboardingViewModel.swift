//
//  of.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 24/07/2026.
//


import Foundation
import SwiftUI

/// Drives a linear, index-based onboarding flow. Kept as a flat enum of
/// steps rather than a NavigationStack path so the progress bar can render
/// "step 2 of 4" without reaching into navigation internals — the original
/// app's onboarding is a fixed sequence, not free-form navigation.
final class OnboardingViewModel: ObservableObject {

    enum Step: Int, CaseIterable {
        case welcome
        case goal
        case level
        case categories

        var title: String {
            switch self {
            case .welcome: "Welcome"
            case .goal: "Goal"
            case .level: "Level"
            case .categories: "Interests"
            }
        }
    }

    @Published private(set) var step: Step = .welcome
    @Published var selectedGoal: LearningGoal?
    @Published var selectedLevel: SkillLevel?
    @Published var selectedCategories: Set<WordCategory> = []

    var progress: Double {
        Double(step.rawValue + 1) / Double(Step.allCases.count)
    }

    var canAdvance: Bool {
        switch step {
        case .welcome: true
        case .goal: selectedGoal != nil
        case .level: selectedLevel != nil
        case .categories: !selectedCategories.isEmpty
        }
    }

    var isLastStep: Bool { step == Step.allCases.last }

    func advance() {
        guard canAdvance else { return }
        HapticManager.shared.fire(.onboardingAdvance)
        guard let next = Step(rawValue: step.rawValue + 1) else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            step = next
        }
    }

    func goBack() {
        guard let previous = Step(rawValue: step.rawValue - 1) else { return }
        withAnimation(.easeInOut(duration: 0.3)) {
            step = previous
        }
    }

    func toggleCategory(_ category: WordCategory) {
        HapticManager.shared.fire(.onboardingSelection)
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }

    func selectGoal(_ goal: LearningGoal) {
        HapticManager.shared.fire(.onboardingSelection)
        selectedGoal = goal
    }

    func selectLevel(_ level: SkillLevel) {
        HapticManager.shared.fire(.onboardingSelection)
        selectedLevel = level
    }
}
