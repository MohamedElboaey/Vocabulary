//
//  WordRepository.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 23/07/2026.
//


protocol WordRepository {
    func fetchWords() async throws -> [Word]
}
