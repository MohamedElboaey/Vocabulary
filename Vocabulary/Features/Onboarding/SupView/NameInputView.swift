import SwiftUI

struct NameInputView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            Text("What do you want to\nbe called?")
                .font(AppTheme.Typography.title)
                .foregroundStyle(AppTheme.Colors.textPrimary)

            TextField("", text: $viewModel.state.name, prompt: Text("Your name").foregroundStyle(AppTheme.Colors.textSecondary))
                .font(AppTheme.Typography.body)
                .foregroundStyle(AppTheme.Colors.textPrimary)
                .padding(18)
                .background(AppTheme.Colors.surface, in: RoundedRectangle(cornerRadius: AppTheme.Metrics.cornerRadiusMedium, style: .continuous))
                .focused($isFocused)
                .submitLabel(.done)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)

            Spacer()
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .padding(.top, 28)
        .onAppear { isFocused = true }
    }
}
