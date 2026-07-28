
import Foundation

struct VoiceOption: Identifiable, Hashable {
    let id: String
    let name: String
    let accent: String

    let localeIdentifier: String

    static let brian = VoiceOption(id: "brian", name: "Brian", accent: "American", localeIdentifier: "en-US")
    static let amelia = VoiceOption(id: "amelia", name: "Amelia", accent: "British", localeIdentifier: "en-GB")
    static let paul = VoiceOption(id: "paul", name: "Paul", accent: "Australian", localeIdentifier: "en-AU")

    static let all: [VoiceOption] = [.brian, .amelia, .paul]

    static func resolve(id: String) -> VoiceOption {
        all.first { $0.id == id } ?? .brian
    }
}
