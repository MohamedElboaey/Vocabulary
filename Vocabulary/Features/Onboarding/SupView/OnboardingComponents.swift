import SwiftUI

struct SelectableRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    var icon: String? = nil
    var subtitle: String? = nil

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(isSelected ? .white : AppTheme.Colors.textSecondary)
                        .frame(width: 40, height: 40)
                        .background(
                            isSelected ? AppTheme.Colors.accent : AppTheme.Colors.surface,
                            in: RoundedRectangle(cornerRadius: 12, style: .continuous)
                        )
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(AppTheme.Typography.headline)
                        .foregroundStyle(AppTheme.Colors.textPrimary)
                    if let subtitle {
                        Text(subtitle)
                            .font(AppTheme.Typography.caption)
                            .foregroundStyle(AppTheme.Colors.textSecondary)
                    }
                }

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(isSelected ? AppTheme.Colors.accent : AppTheme.Colors.textSecondary.opacity(0.5))
                    .font(.system(size: 22))
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.Metrics.cornerRadiusMedium, style: .continuous)
                    .fill(AppTheme.Colors.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: AppTheme.Metrics.cornerRadiusMedium, style: .continuous)
                            .strokeBorder(isSelected ? AppTheme.Colors.accent : .clear, lineWidth: 2)
                    )
            )
        }
        .buttonStyle(PressableButtonStyle())
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
