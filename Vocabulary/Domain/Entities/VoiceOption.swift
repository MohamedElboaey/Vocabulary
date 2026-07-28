//
//  in.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 24/07/2026.
//


import Foundation

/// A pronunciation voice the learner can pick in onboarding. Kept as a
/// plain data struct in Domain (no AVFoundation import here) — the actual
/// `AVSpeechSynthesisVoice` lookup happens in `Core/Speech/SpeechService`,
/// which is the only place that needs to know speech synthesis exists.
struct VoiceOption: Identifiable, Hashable {
    let id: String
    let name: String
    let accent: String
    /// BCP-47 locale used to pick a system voice for this accent. Real
    /// per-persona voices (a distinct "Brian" vs "Mia") would come from a
    /// premium TTS vendor; the system voice for the matching locale is the
    /// closest zero-dependency approximation for an MVP.
    let localeIdentifier: String

    static let brian = VoiceOption(id: "brian", name: "Brian", accent: "American", localeIdentifier: "en-US")
    static let mia = VoiceOption(id: "mia", name: "Mia", accent: "American", localeIdentifier: "en-US")
    static let amelia = VoiceOption(id: "amelia", name: "Amelia", accent: "British", localeIdentifier: "en-GB")
    static let frederick = VoiceOption(id: "frederick", name: "Frederick", accent: "British", localeIdentifier: "en-GB")
    static let paul = VoiceOption(id: "paul", name: "Paul", accent: "Australian", localeIdentifier: "en-AU")
    static let matilda = VoiceOption(id: "matilda", name: "Matilda", accent: "Australian", localeIdentifier: "en-AU")

    static let all: [VoiceOption] = [.brian, .mia, .amelia, .frederick, .paul, .matilda]

    static func resolve(id: String) -> VoiceOption {
        all.first { $0.id == id } ?? .brian
    }
}