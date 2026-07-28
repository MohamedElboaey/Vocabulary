import SwiftUI

/// Alternate app-icon choices offered during onboarding. The 1-week MVP
/// brief explicitly allows skipping the app-icon picker, but the
/// reference screenshots show it as a real onboarding step, so it's
/// modeled here for visual parity — selecting one just persists the
/// choice; it does not call `UIApplication.setAlternateIconName`, since
/// wiring real `.icon` asset variants is outside a 1-week MVP's scope.
enum AppIconStyle: String, CaseIterable, Identifiable {
    case cream, dark, coral, sunset, mint, dusk

    var id: String { rawValue }

    var backgroundColors: [Color] {
        switch self {
        case .cream: [Color(hex: "EFE8D6")]
        case .dark: [Color(hex: "1C1D24")]
        case .coral: [Color(hex: "E8735F")]
        case .sunset: [Color(hex: "F6B25A"), Color(hex: "E8735F")]
        case .mint: [Color(hex: "A9D18E")]
        case .dusk: [Color(hex: "5A6B7A"), Color(hex: "E8735F")]
        }
    }

    var glyphColor: Color {
        switch self {
        case .cream: .black
        default: .white
        }
    }
}