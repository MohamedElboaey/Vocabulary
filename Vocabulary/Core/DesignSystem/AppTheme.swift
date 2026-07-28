
import SwiftUI

enum AppTheme {

    enum Colors {
        static let background = Color(hex: "0E0F1A")
        static let surface = Color(hex: "1A1C2C")
        static let surfaceElevated = Color(hex: "23253A")
        static let textPrimary = Color.white
        static let textSecondary = Color.white.opacity(0.62)
        static let accent = Color(hex: "6C5CE7")
        static let accentSecondary = Color(hex: "00D2A0")
        static let danger = Color(hex: "FF6B6B")
        static let warning = Color(hex: "FFB347")

        /// Deterministic gradient per word so the deck feels alive without
        /// randomness causing flicker on re-render.
        static func cardGradient(for seed: Int) -> LinearGradient {
            let palettes: [[Color]] = [
                [Color(hex: "6C5CE7"), Color(hex: "341F97")],
                [Color(hex: "00B894"), Color(hex: "00695C")],
                [Color(hex: "0984E3"), Color(hex: "1B3B6F")],
                [Color(hex: "E17055"), Color(hex: "8E2DE2")],
                [Color(hex: "FD79A8"), Color(hex: "6C5CE7")],
                [Color(hex: "FDCB6E"), Color(hex: "E17055")]
            ]
            let palette = palettes[abs(seed) % palettes.count]
            return LinearGradient(colors: palette, startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    enum Typography {
        static let largeTitle = Font.system(size: 34, weight: .bold, design: .rounded)
        static let title = Font.system(size: 26, weight: .bold, design: .rounded)
        static let headline = Font.system(size: 20, weight: .semibold, design: .rounded)
        static let body = Font.system(size: 17, weight: .regular, design: .default)
        static let subheadline = Font.system(size: 15, weight: .medium, design: .default)
        static let caption = Font.system(size: 13, weight: .medium, design: .default)
        static let wordDisplay = Font.system(size: 40, weight: .heavy, design: .rounded)
    }

    enum Metrics {
        static let cornerRadiusLarge: CGFloat = 32
        static let cornerRadiusMedium: CGFloat = 20
        static let cornerRadiusSmall: CGFloat = 12
        static let horizontalPadding: CGFloat = 24
    }
}

extension Color {
    /// Convenience initializer so design tokens can be authored as hex,
    /// matching how the palette is usually handed off by design.
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255
        let b = Double(rgbValue & 0x0000FF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
