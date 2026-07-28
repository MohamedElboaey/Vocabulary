//
//  ReadingTheme.swift
//  Vocabulary
//
//  Created by Mohamed Elboraey on 24/07/2026.
//


import SwiftUI

/// The background a learner reads words against. In the real app these
/// swatches are short looping videos (a rainy cabin, a library, a rainy
/// street); this MVP renders them as gradients so it has zero binary
/// assets to ship, but every case already carries an `isVideoLoop` flag
/// and a `label` — swapping in an `AVPlayerLooper`-backed background later
/// is additive (see `ThemedBackground` in ThemePickerView.swift), not a
/// rewrite of anything that reads `ReadingTheme`.
enum ReadingTheme: String, CaseIterable, Identifiable {
    case darkMinimal, lightMinimal, forestCabin, libraryLadder, spiralLibrary, rainyStreet

    var id: String { rawValue }

    var label: String {
        switch self {
        case .darkMinimal: "Dark"
        case .lightMinimal: "Light"
        case .forestCabin: "Forest Cabin"
        case .libraryLadder: "Library"
        case .spiralLibrary: "Spiral Library"
        case .rainyStreet: "Rainy Street"
        }
    }

    /// Real asset placeholders would live here instead: video/cabin.mp4 etc.
    var isVideoLoop: Bool {
        switch self {
        case .darkMinimal, .lightMinimal: false
        case .forestCabin, .libraryLadder, .spiralLibrary, .rainyStreet: true
        }
    }

    var previewColors: [Color] {
        switch self {
        case .darkMinimal: [Color(hex: "111218"), Color(hex: "0B0C10")]
        case .lightMinimal: [Color(hex: "F1ECDD"), Color(hex: "E4DCC5")]
        case .forestCabin: [Color(hex: "2E4A44"), Color(hex: "0F1C1B")]
        case .libraryLadder: [Color(hex: "3B2E22"), Color(hex: "17110C")]
        case .spiralLibrary: [Color(hex: "4A3826"), Color(hex: "1D140D")]
        case .rainyStreet: [Color(hex: "3A2F3D"), Color(hex: "141018")]
        }
    }

    var foregroundIsLight: Bool {
        self != .lightMinimal
    }
}