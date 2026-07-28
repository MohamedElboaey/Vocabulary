

import Foundation

enum OnboardingStep: Int, CaseIterable {

    case welcome
    case name
    case age
    case gender
    case referral
    case customizePrompt
    case pace
    case habitHelper
    case topics
    case theme
    case iconStyle
    case voice
    case streak

    var isSkippable: Bool {
        switch self {

        case .name,
             .age,
             .gender,
             .referral,
             .pace,
             .habitHelper,
             .topics:
            return true

        default:
            return false
        }
    }

    var next: OnboardingStep? {
        OnboardingStep(rawValue: rawValue + 1)
    }

    var previous: OnboardingStep? {
        OnboardingStep(rawValue: rawValue - 1)
    }
}
