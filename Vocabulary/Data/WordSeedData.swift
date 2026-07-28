
import Foundation

enum WordSeedData {
    static let all: [Word] = [
        Word(id: UUID(), term: "Ephemeral", phonetic: "/ɪˈfɛm.ər.əl/", partOfSpeech: "adjective",
             definition: "Lasting for a very short time.",
             example: "Fame on social media can be ephemeral, gone within a week.",
             synonyms: ["fleeting", "transient", "momentary"], difficulty: .advanced, mastery: .new),

        Word(id: UUID(), term: "Meticulous", phonetic: "/mɪˈtɪk.jə.ləs/", partOfSpeech: "adjective",
             definition: "Showing great attention to detail; very careful and precise.",
             example: "She kept meticulous records of every transaction.",
             synonyms: ["thorough", "precise", "scrupulous"], difficulty: .intermediate, mastery: .new),

        Word(id: UUID(), term: "Candid", phonetic: "/ˈkæn.dɪd/", partOfSpeech: "adjective",
             definition: "Truthful and straightforward; frank.",
             example: "He gave a candid answer, even though it wasn't flattering.",
             synonyms: ["honest", "frank", "forthright"], difficulty: .beginner, mastery: .new),

        Word(id: UUID(), term: "Resilient", phonetic: "/rɪˈzɪl.i.ənt/", partOfSpeech: "adjective",
             definition: "Able to recover quickly from difficulties.",
             example: "The startup team stayed resilient after their first product failed.",
             synonyms: ["tough", "adaptable", "hardy"], difficulty: .beginner, mastery: .new),

        Word(id: UUID(), term: "Ambivalent", phonetic: "/æmˈbɪv.ə.lənt/", partOfSpeech: "adjective",
             definition: "Having mixed feelings or contradictory ideas about something.",
             example: "I'm ambivalent about the move — excited, but also nervous.",
             synonyms: ["torn", "conflicted", "uncertain"], difficulty: .intermediate, mastery: .new),

        Word(id: UUID(), term: "Pragmatic", phonetic: "/præɡˈmæt.ɪk/", partOfSpeech: "adjective",
             definition: "Dealing with things sensibly and realistically.",
             example: "The manager took a pragmatic approach to the tight deadline.",
             synonyms: ["practical", "realistic", "sensible"], difficulty: .intermediate, mastery: .new),

        Word(id: UUID(), term: "Ubiquitous", phonetic: "/juːˈbɪk.wɪ.təs/", partOfSpeech: "adjective",
             definition: "Present, appearing, or found everywhere.",
             example: "Smartphones have become ubiquitous in modern life.",
             synonyms: ["omnipresent", "widespread", "pervasive"], difficulty: .advanced, mastery: .new),

        Word(id: UUID(), term: "Cordial", phonetic: "/ˈkɔːr.dʒəl/", partOfSpeech: "adjective",
             definition: "Warm and friendly.",
             example: "Despite the disagreement, their conversation stayed cordial.",
             synonyms: ["friendly", "warm", "amiable"], difficulty: .beginner, mastery: .new),

        Word(id: UUID(), term: "Nuance", phonetic: "/ˈnjuː.ɑːns/", partOfSpeech: "noun",
             definition: "A subtle difference in meaning, expression, or sound.",
             example: "Good translators capture the nuance of the original text.",
             synonyms: ["subtlety", "shade", "distinction"], difficulty: .intermediate, mastery: .new),

        Word(id: UUID(), term: "Tenacious", phonetic: "/tɪˈneɪ.ʃəs/", partOfSpeech: "adjective",
             definition: "Persisting firmly, especially in the face of obstacles.",
             example: "Her tenacious pursuit of the bug finally paid off at 2am.",
             synonyms: ["persistent", "determined", "unyielding"], difficulty: .intermediate, mastery: .new),

        Word(id: UUID(), term: "Cogent", phonetic: "/ˈkoʊ.dʒənt/", partOfSpeech: "adjective",
             definition: "Clear, logical, and convincing.",
             example: "He made a cogent argument for refactoring the module.",
             synonyms: ["compelling", "persuasive", "convincing"], difficulty: .advanced, mastery: .new),

        Word(id: UUID(), term: "Genuine", phonetic: "/ˈdʒɛn.ju.ɪn/", partOfSpeech: "adjective",
             definition: "Truly what it is said to be; authentic.",
             example: "Her surprise was genuine — she hadn't seen it coming.",
             synonyms: ["authentic", "real", "sincere"], difficulty: .beginner, mastery: .new),

        Word(id: UUID(), term: "Discern", phonetic: "/dɪˈsɜːrn/", partOfSpeech: "verb",
             definition: "To perceive or recognize something clearly.",
             example: "It took a moment to discern the pattern in the data.",
             synonyms: ["perceive", "recognize", "distinguish"], difficulty: .intermediate, mastery: .new),

        Word(id: UUID(), term: "Sycophant", phonetic: "/ˈsɪk.ə.fənt/", partOfSpeech: "noun",
             definition: "A person who flatters someone to gain an advantage.",
             example: "The court was full of sycophants eager to please the king.",
             synonyms: ["flatterer", "yes-man", "toady"], difficulty: .advanced, mastery: .new),

        Word(id: UUID(), term: "Concise", phonetic: "/kənˈsaɪs/", partOfSpeech: "adjective",
             definition: "Giving a lot of information clearly in a few words.",
             example: "Good code review comments are concise and specific.",
             synonyms: ["brief", "succinct", "compact"], difficulty: .beginner, mastery: .new),

        Word(id: UUID(), term: "Serendipity", phonetic: "/ˌsɛr.ənˈdɪp.ɪ.ti/", partOfSpeech: "noun",
             definition: "The occurrence of finding pleasant things by chance.",
             example: "Meeting his co-founder on that flight was pure serendipity.",
             synonyms: ["chance", "fluke", "luck"], difficulty: .advanced, mastery: .new),
    ]
}
