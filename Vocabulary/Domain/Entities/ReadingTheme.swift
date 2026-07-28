
import SwiftUI

enum ReadingTheme: String, CaseIterable, Identifiable {

    case autumnLeaves
    case sunsetLake
    case moonForest
    case woodenPier
    case autumnCafe
    case vintageCity

    var id: String { rawValue }

    var label: String {
        switch self {
        case .autumnLeaves:
            return "Leaves"

        case .sunsetLake:
            return "Sunset"

        case .moonForest:
            return "Moon"

        case .woodenPier:
            return "Lake"

        case .autumnCafe:
            return "Cafe"

        case .vintageCity:
            return "Vintage"
        }
    }

    /// Image used in the picker
    var previewImage: String {
        switch self {
        case .autumnLeaves:
            return "theme_leaves"

        case .sunsetLake:
            return "theme_sunset"

        case .moonForest:
            return "theme_moon"

        case .woodenPier:
            return "theme_lake"

        case .autumnCafe:
            return "theme_cafe"

        case .vintageCity:
            return "theme_city"
        }
    }

    var backgroundImage: String {
        previewImage
    }

    var foregroundIsLight: Bool {
        switch self {
        case .autumnLeaves:
            return false

        default:
            return true
        }
    }
}
