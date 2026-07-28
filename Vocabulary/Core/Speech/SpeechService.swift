
import AVFoundation

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
