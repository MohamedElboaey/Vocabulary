
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

                    case .name:
                        NameInputView(viewModel: viewModel)

                    case .age:
                        OnboardingChoiceListView(
                            title: "How old are you?",
                            options: AgeRange.allCases,
                            selected: viewModel.state.age,
                            onSelect: viewModel.selectAge
                        )

                    case .gender:
                        OnboardingChoiceListView(
                            title: "Which option represents\nyou best?",
                            options: Gender.allCases,
                            selected: viewModel.state.gender,
                            onSelect: viewModel.selectGender
                        )

                    case .referral:
                        OnboardingChoiceListView(
                            title: "How did you hear\nabout Vocabulary?",
                            options: ReferralSource.allCases,
                            selected: viewModel.state.referral,
                            onSelect: viewModel.selectReferral
                        )

                    case .customizePrompt:
                        CustomizePromptView()

                    case .pace:
                        OnboardingChoiceListView(
                            title: "Set your learning goal",
                            options: LearningPace.allCases,
                            selected: viewModel.state.pace,
                            onSelect: viewModel.selectLearningPace
                        )

                    case .habitHelper:
                        OnboardingChoiceListView(
                            title: "What would help make\nlearning a daily habit?",
                            options: HabitHelper.allCases,
                            selected: viewModel.state.habitHelper,
                            onSelect: viewModel.selectHabitHelper
                        )

                    case .topics:
                        CategoryInterestView(viewModel: viewModel)

                    case .theme:
                        ThemePickerView(viewModel: viewModel)

                    case .iconStyle:
                        IconStylePickerView(viewModel: viewModel)

                    case .voice:
                        VoicePickerView(viewModel: viewModel)

                    case .streak:
                        StreakIntroView()
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
        VStack(spacing: 10) {
            HStack(spacing: 16) {
                if viewModel.step.previous != nil {
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

            if viewModel.step.isSkippable {
                HStack {
                    Spacer()
                    Button("Skip", action: viewModel.skip)
                        .font(AppTheme.Typography.subheadline)
                        .foregroundStyle(AppTheme.Colors.textSecondary)
                }
            }
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .padding(.top, 12)
    }

    private var footer: some View {
        Button(action: handlePrimaryAction) {
            Text(viewModel.primaryButtonTitle)
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
        hideKeyboard()
        if viewModel.isLastStep {
            onFinished()
            return
        }
        viewModel.advance()
    }
}
