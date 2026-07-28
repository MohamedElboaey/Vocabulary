import SwiftUI

struct IconStylePickerView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    private let columns = [GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14), GridItem(.flexible(), spacing: 14)]

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            Text("Which icon style do\nyou like the most?")
                .font(AppTheme.Typography.title)
                .foregroundStyle(AppTheme.Colors.textPrimary)

            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(AppIconStyle.allCases) { style in
                    IconSwatch(
                        style: style,
                        isSelected: viewModel.state.iconStyle == style
                    ) {
                        viewModel.selectIcon(style)
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .padding(.top, 28)
    }
}

private struct IconSwatch: View {

    let style: AppIconStyle
    let isSelected: Bool
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            ZStack(alignment: .topTrailing) {

                Image(style.previewImageName)
                    .resizable()
                    .scaledToFit()
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 22,
                            style: .continuous
                        )
                    )
                    .overlay {

                        RoundedRectangle(
                            cornerRadius: 22,
                            style: .continuous
                        )
                        .stroke(
                            isSelected
                            ? AppTheme.Colors.accentSecondary
                            : Color.clear,
                            lineWidth: 3
                        )

                    }
                    .shadow(
                        color: .black.opacity(0.18),
                        radius: 8,
                        y: 4
                    )

                if isSelected {

                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(AppTheme.Colors.accentSecondary)
                        .background(Circle().fill(.white))
                        .padding(8)

                }

            }

        }
        .buttonStyle(PressableButtonStyle())
        .animation(.spring(response: 0.3), value: isSelected)

    }

}
