//
//  boundary.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 24/07/2026.
//


import Foundation

/// In-memory stand-in for a real backend. In production this would be a
/// thin adapter over Mohamed's NetworkManager + XMLMapper stack; the
/// protocol boundary in Domain is what makes that swap non-invasive.
final class MockWordRepository: WordRepositoryProtocol {

    private var storage: [UUID: Word]
    private let queue = DispatchQueue(label: "MockWordRepository.storage")

    init() {
        var dict = [UUID: Word]()
        WordSeedData.all.forEach { dict[$0.id] = $0 }
        self.storage = dict
    }

    func fetchDeck(for level: SkillLevel?, categories: Set<WordCategory>) -> [Word] {
        // Category/level filtering is intentionally a no-op pass-through in
        // the MVP seed set (categories aren't tagged per-word yet) — the
        // signature exists so HomeViewModel can personalize the deck the
        // moment richer seed data lands, without touching call sites.
        queue.sync { Array(storage.values).sorted { $0.term < $1.term } }
    }

    func updateMastery(wordID: UUID, to state: MasteryState) {
        queue.sync {
            storage[wordID]?.mastery = state
        }
    }
}
