//
//  OnboardingChoice.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 24/07/2026.
//


import Foundation

/// Common shape for every single-tap onboarding question (age, gender,
/// referral source, learning pace, habit helper, ...). Conforming here
/// once, instead of duplicating a `SelectableRow`-driving view per
/// question, is what lets `OnboardingChoiceListView` render all of them
/// from one implementation — see that file for the payoff.
protocol OnboardingChoice: Identifiable, Hashable where ID == String {
    var displayTitle: String { get }
    var displaySubtitle: String? { get }
    var icon: String? { get }
}

extension OnboardingChoice {
    var displaySubtitle: String? { nil }
    var icon: String? { nil }
}

enum LearningPace: String, CaseIterable, OnboardingChoice {
    case easy, serious, ambitious

    var id: String { rawValue }
    var wordsPerWeek: Int {
        switch self {
        case .easy: 10
        case .serious: 30
        case .ambitious: 50
        }
    }
    var displayTitle: String {
        switch self {
        case .easy: "Easy: \(wordsPerWeek) words/week"
        case .serious: "Serious: \(wordsPerWeek) words/week"
        case .ambitious: "Ambitious: \(wordsPerWeek) words/week"
        }
    }
}

enum AgeRange: String, CaseIterable, OnboardingChoice {
    case teen, youngAdult, adult, midAdult, olderAdult, senior

    var id: String { rawValue }
    var displayTitle: String {
        switch self {
        case .teen: "13 to 17"
        case .youngAdult: "18 to 24"
        case .adult: "25 to 34"
        case .midAdult: "35 to 44"
        case .olderAdult: "45 to 54"
        case .senior: "55+"
        }
    }
}

enum Gender: String, CaseIterable, OnboardingChoice {
    case female, male, other, preferNotToSay

    var id: String { rawValue }
    var displayTitle: String {
        switch self {
        case .female: "Female"
        case .male: "Male"
        case .other: "Other"
        case .preferNotToSay: "Prefer not to say"
        }
    }
}

enum ReferralSource: String, CaseIterable, OnboardingChoice {
    case facebook, tiktok, webSearch, appStore, friendFamily, instagram, other

    var id: String { rawValue }
    var displayTitle: String {
        switch self {
        case .facebook: "Facebook"
        case .tiktok: "TikTok"
        case .webSearch: "Web search"
        case .appStore: "App Store"
        case .friendFamily: "Friend/family"
        case .instagram: "Instagram"
        case .other: "Other"
        }
    }
}

enum HabitHelper: String, CaseIterable, OnboardingChoice {
    case quizzesAndGames, progressTracking, widget, reminders

    var id: String { rawValue }
    var displayTitle: String {
        switch self {
        case .quizzesAndGames: "Personalized quizzes and games"
        case .progressTracking: "Tracking my progress"
        case .widget: "A home/lock screen widget"
        case .reminders: "Getting regular reminders"
        }
    }
}

enum WordCategory: String, CaseIterable, OnboardingChoice {
    case society, humanBody, emotions, business, other

    var id: String { rawValue }
    var displayTitle: String {
        switch self {
        case .society: "Society"
        case .humanBody: "Human body"
        case .emotions: "Emotions"
        case .business: "Business"
        case .other: "Other"
        }
    }
    var icon: String? {
        switch self {
        case .society: "person.3.fill"
        case .humanBody: "figure.stand"
        case .emotions: "face.smiling.fill"
        case .business: "briefcase.fill"
        case .other: "ellipsis.circle.fill"
        }
    }
}