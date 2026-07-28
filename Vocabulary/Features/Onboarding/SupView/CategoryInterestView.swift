import SwiftUI

struct CategoryInterestView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    private let columns = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Which topics are you\ninterested in?")
                    .font(AppTheme.Typography.title)
                    .foregroundStyle(AppTheme.Colors.textPrimary)
                Text("Select at least one. You can change this later.")
                    .font(AppTheme.Typography.body)
                    .foregroundStyle(AppTheme.Colors.textSecondary)
            }

            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(WordCategory.allCases) { category in
                    CategoryChip(
                        category: category,
                        isSelected: viewModel.state.selectedCategories.contains(category)
                    ) {
                        viewModel.toggleCategory(category)
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .padding(.top, 28)
    }
}

private struct CategoryChip: View {
    let category: WordCategory
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 12) {
                if let icon = category.icon {
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(isSelected ? .white : AppTheme.Colors.textSecondary)
                }

                Text(category.displayTitle)
                    .font(AppTheme.Typography.subheadline)
                    .foregroundStyle(isSelected ? .white : AppTheme.Colors.textPrimary)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .frame(height: 100)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.Metrics.cornerRadiusMedium, style: .continuous)
                    .fill(isSelected ? AppTheme.Colors.accent : AppTheme.Colors.surface)
            )
        }
        .buttonStyle(PressableButtonStyle())
        .animation(.easeInOut(duration: 0.15), value: isSelected)
    }
}
