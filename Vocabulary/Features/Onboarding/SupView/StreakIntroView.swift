import SwiftUI

struct StreakIntroView: View {
    private let days = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
    private var todayIndex: Int {
        Calendar.current.component(.weekday, from: .now) - 1
    }

    var body: some View {
        VStack(spacing: 28) {
            Spacer()

            Image(systemName: "flame.fill")
                .font(.system(size: 76))
                .foregroundStyle(AppTheme.Colors.warning)
                .overlay(
                    Text("1")
                        .font(.system(size: 26, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .offset(y: 10)
                )

            Text("Create a consistent daily\nlearning routine")
                .font(AppTheme.Typography.title)
                .multilineTextAlignment(.center)
                .foregroundStyle(AppTheme.Colors.textPrimary)

            HStack(spacing: 10) {
                ForEach(orderedDays.indices, id: \.self) { i in
                    VStack(spacing: 10) {
                        Text(orderedDays[i])
                            .font(AppTheme.Typography.caption)
                            .foregroundStyle(i == 0 ? AppTheme.Colors.textPrimary : AppTheme.Colors.textSecondary)
                        Circle()
                            .fill(i == 0 ? AppTheme.Colors.accentSecondary : AppTheme.Colors.surface)
                            .frame(width: 34, height: 34)
                            .overlay(
                                i == 0 ? Image(systemName: "checkmark").font(.system(size: 13, weight: .bold)).foregroundStyle(.black) : nil
                            )
                    }
                }
            }
            .padding(18)
            .background(AppTheme.Colors.surface.opacity(0.5), in: RoundedRectangle(cornerRadius: 20, style: .continuous))

            Text("Build a streak, one day at a time")
                .font(AppTheme.Typography.caption)
                .foregroundStyle(AppTheme.Colors.textSecondary)

            Spacer()
            Spacer()
        }
        .padding(.horizontal, AppTheme.Metrics.horizontalPadding)
    }

    private var orderedDays: [String] {
        Array(days[todayIndex...] + days[..<todayIndex])
    }
}
