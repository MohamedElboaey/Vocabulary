
import SwiftUI

enum AppIconStyle: String, CaseIterable, Identifiable {

    case cream
    case dark
    case coral
    case sunset
    case mint
    case dusk

    var id: String { rawValue }

    var previewImageName: String {
        switch self {
        case .cream: return "AppIconPreview"
        case .dark: return "AppIconDarkPreview"
        case .coral: return "AppIconCoralPreview"
        case .sunset: return "AppIconSunsetPreview"
        case .mint: return "AppIconMintPreview"
        case .dusk: return "AppIconDuskPreview"
        }
    }

    var alternateIconName: String? {
        switch self {
        case .cream:
            return nil

        case .dark:
            return "AppIconDark"

        case .coral:
            return "AppIconCoral"

        case .sunset:
            return "AppIconSunset"

        case .mint:
            return "AppIconMint"

        case .dusk:
            return "AppIconDusk"
        }
    }

    var title: String {
        rawValue.capitalized
    }
}
