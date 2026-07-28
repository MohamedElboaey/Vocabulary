import SwiftUI

struct ThemePickerView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    private let columns = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            Text("Which theme would\nyou like to start with?")
                .font(AppTheme.Typography.title)
                .foregroundStyle(AppTheme.Colors.textPrimary)
                .multilineTextAlignment(.leading)

            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(ReadingTheme.allCases) { theme in
                    ThemeSwatch(
                        theme: theme,
                        isSelected: viewModel.state.theme == theme,
                        action: { viewModel.selectTheme(theme) }
                    )
                }
            }

            Spacer()
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .padding(.top, 28)
    }
}

private struct ThemeSwatch: View {
    let theme: ReadingTheme
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                ThemedBackground(theme: theme)
                    .aspectRatio(0.62, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .strokeBorder(isSelected ? AppTheme.Colors.accentSecondary : .clear, lineWidth: 3)
                    )
                    .overlay(
                        Text("Aa")
                            .font(.system(size: 22, weight: .bold, design: .serif))
                            .foregroundStyle(theme.foregroundIsLight ? .white : .black)
                    )

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(AppTheme.Colors.accentSecondary)
                        .background(Circle().fill(.white))
                        .padding(6)
                }
            }
        }
        .buttonStyle(PressableButtonStyle())
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}
