import SwiftUI

struct OnboardingChoiceListView<Option: OnboardingChoice>: View {
    let title: String
    var subtitle: String? = nil
    let options: [Option]
    let selected: Option?
    let onSelect: (Option) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(AppTheme.Typography.title)
                    .foregroundStyle(AppTheme.Colors.textPrimary)
                if let subtitle {
                    Text(subtitle)
                        .font(AppTheme.Typography.body)
                        .foregroundStyle(AppTheme.Colors.textSecondary)
                }
            }

            VStack(spacing: 14) {
                ForEach(options) { option in
                    SelectableRow(
                        title: option.displayTitle,
                        isSelected: selected == option,
                        action: { onSelect(option) },
                        icon: option.icon,
                        subtitle: option.displaySubtitle
                    )
                }
            }

            Spacer()
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .padding(.top, 28)
    }
}
