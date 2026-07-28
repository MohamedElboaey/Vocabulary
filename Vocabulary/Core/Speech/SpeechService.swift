//
//  SpeechService.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 24/07/2026.
//


import AVFoundation

/// Thin wrapper around `AVSpeechSynthesizer` so the Home feature can say
/// "pronounce this word in the selected voice" without knowing AVFoundation
/// exists. Mirrors `HapticManager`'s role: one shared, prepared resource
/// instead of every call site constructing its own synthesizer.
final class SpeechService {

    static let shared = SpeechService()

    private let synthesizer = AVSpeechSynthesizer()

    private init() {}

    func speak(_ text: String, voice: VoiceOption) {
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: voice.localeIdentifier)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.92
        synthesizer.speak(utterance)
    }
}