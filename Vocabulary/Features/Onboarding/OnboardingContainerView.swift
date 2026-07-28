import SwiftUI

struct OnboardingContainerView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    let onFinished: () -> Void

    var body: some View {
        ZStack {
            AppTheme.Colors.background.ignoresSafeArea()

            VStack(spacing: 0) {
                header

                Group {
                    switch viewModel.step {
                    case .welcome:
                        WelcomeView()
                    case .goal:
                        GoalSelectionView(viewModel: viewModel)
                    case .level:
                        LevelSelectionView(viewModel: viewModel)
                    case .categories:
                        CategoryInterestView(viewModel: viewModel)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
                .id(viewModel.step)

                footer
            }
        }
    }

    private var header: some View {
        HStack(spacing: 16) {
            if viewModel.step != .welcome {
                Button(action: viewModel.goBack) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(AppTheme.Colors.textPrimary)
                        .frame(width: 36, height: 36)
                        .background(AppTheme.Colors.surface, in: Circle())
                }
            }

            OnboardingProgressBar(progress: viewModel.progress)
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .padding(.top, 12)
    }

    private var footer: some View {
        Button(action: handlePrimaryAction) {
            Text(viewModel.isLastStep ? "Get Started" : "Continue")
                .font(AppTheme.Typography.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    viewModel.canAdvance ? AppTheme.Colors.accent : AppTheme.Colors.surfaceElevated,
                    in: RoundedRectangle(cornerRadius: AppTheme.Metrics.cornerRadiusMedium, style: .continuous)
                )
        }
        .disabled(!viewModel.canAdvance)
        .animation(.easeInOut(duration: 0.2), value: viewModel.canAdvance)
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .padding(.bottom, 16)
    }

    private func handlePrimaryAction() {
        if viewModel.isLastStep {
            onFinished()
        } else {
            viewModel.advance()
        }
    }
}

struct OnboardingProgressBar: View {
    let progress: Double

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule().fill(AppTheme.Colors.surface)
                Capsule()
                    .fill(AppTheme.Colors.accent)
                    .frame(width: proxy.size.width * progress)
                    .animation(.easeInOut(duration: 0.3), value: progress)
            }
        }
        .frame(height: 6)
    }
}
