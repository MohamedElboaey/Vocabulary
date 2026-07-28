import SwiftUI

struct VoicePickerView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            Text("Choose a voice to\npronounce words")
                .font(AppTheme.Typography.title)
                .foregroundStyle(AppTheme.Colors.textPrimary)

            VStack(spacing: 14) {
                ForEach(VoiceOption.all) { voice in
                    VoiceRow(
                        voice: voice,
                        isSelected: viewModel.state.voice == voice,
                        onSelect: { viewModel.selectVoice(voice) },
                        onPreview: {
                            HapticManager.shared.fire(.voicePreview)
                            SpeechService.shared.speak("Perspicacious.", voice: voice)
                        }
                    )
                }
            }

            Spacer()
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
        .padding(.top, 28)
    }
}

private struct VoiceRow: View {
    let voice: VoiceOption
    let isSelected: Bool
    let onSelect: () -> Void
    let onPreview: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 14) {
                Button(action: onPreview) {
                    Image(systemName: "play.fill")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(isSelected ? .black : AppTheme.Colors.textPrimary)
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)

                VStack(alignment: .leading, spacing: 2) {
                    Text(voice.name)
                        .font(AppTheme.Typography.headline)
                        .foregroundStyle(isSelected ? .black : AppTheme.Colors.textPrimary)
                    Text(voice.accent)
                        .font(AppTheme.Typography.caption)
                        .foregroundStyle(isSelected ? .black.opacity(0.6) : AppTheme.Colors.textSecondary)
                }

                Spacer()

                Waveform(isSelected: isSelected)
                    .frame(width: 100, height: 20)

                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                    .font(.system(size: 20))
                    .foregroundStyle(isSelected ? .black : AppTheme.Colors.textSecondary.opacity(0.6))
            }
            .padding(16)
            .background(
                isSelected ? AppTheme.Colors.accentSecondary : AppTheme.Colors.surface,
                in: RoundedRectangle(cornerRadius: AppTheme.Metrics.cornerRadiusMedium, style: .continuous)
            )
        }
        .buttonStyle(PressableButtonStyle())
    }
}

private struct Waveform: View {
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<18, id: \.self) { i in
                RoundedRectangle(cornerRadius: 1)
                    .fill((isSelected ? Color.black : AppTheme.Colors.textSecondary).opacity(0.5))
                    .frame(width: 2, height: barHeight(i))
            }
        }
    }

    private func barHeight(_ index: Int) -> CGFloat {
        let pattern: [CGFloat] = [6, 12, 8, 16, 10, 14, 6, 18, 9, 13, 7, 15, 11, 17, 8, 12, 6, 10]
        return pattern[index % pattern.count]
    }
}
