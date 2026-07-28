

import Foundation

struct OnboardingState {

    var name = ""

    var age: AgeRange?

    var gender: Gender?

    var referral: ReferralSource?

    var pace: LearningPace?

    var habitHelper: HabitHelper?

    var selectedCategories: Set<WordCategory> = []

    var theme: ReadingTheme = .autumnLeaves

    var iconStyle: AppIconStyle = .cream

    var voice: VoiceOption = .brian
}
