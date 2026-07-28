import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    @State private var dragOffset: CGFloat = 0
    @State private var hasFiredThresholdHaptic = false
    @State private var transitionEdge: Edge = .top
    @State private var showWordDetail = false
    @State private var animateArrow = false
    @State private var showHeartBurst = false
    @State private var sheetHeight: CGFloat = 400

    private let commitThreshold: CGFloat = 90

    var body: some View {
        ZStack {
            VStack {
                header
                Spacer()

                Color.clear
                    .contentShape(Rectangle())
                    .overlay {
                        Group {
                            switch viewModel.state {
                            case .intro:
                                introView
                            case .word:
                                if let word = viewModel.currentWord {
                                    wordContent(word)
                                        .offset(y: dragOffset)
                                        .transition(feedTransition)
                                        .id(word.id)
                                }
                            }
                        }
                        .animation(.easeInOut(duration: 0.6), value: viewModel.state)
                    }
                    .overlay { heartBurstOverlay }
                    .gesture(dragGesture)
                    .simultaneousGesture(doubleTapGesture)

                Spacer()
                bottomActions
            }
            .padding(.vertical, 50)
            .background {
                ThemedBackground(theme: viewModel.theme)
                    .overlay(Color.black.opacity(0.3))
            }
            .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                animateArrow = true
            }
        }
        .sheet(item: $viewModel.activeQuiz) { quiz in
            DynamicHeightView(height: $sheetHeight) {
                quizSheet(quiz)
            }
            .presentationDetents([.height(sheetHeight)])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showWordDetail) {
            if let word = viewModel.currentWord {
                DynamicHeightView(height: $sheetHeight) {
                    WordDetailSheetView(word: word)
                }
                .presentationDetents([.height(sheetHeight)])
                .presentationDragIndicator(.visible)
            }
        }
    }

    @ViewBuilder
    private func quizSheet(_ quiz: HomeQuiz) -> some View {
        switch quiz {
        case .recall(let recallQuiz):
            RecallQuizView(quiz: recallQuiz, onAnswer: viewModel.submitQuizAnswer, onDismiss: viewModel.dismissQuiz)
        case .scramble(let scrambleQuiz):
            ScrambleQuizView(quiz: scrambleQuiz, onAnswer: viewModel.submitQuizAnswer, onDismiss: viewModel.dismissQuiz)
        }
    }

    private func wordContent(_ word: Word) -> some View {
        VStack(spacing: 20) {
            Text(word.term)
                .font(.system(size: 48, weight: .regular, design: .serif))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            pronunciationChip(word)

            Text(word.definition)
                .font(.title3)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity)
        .animation(.easeInOut(duration: 0.25), value: word.id)
    }

    @ViewBuilder
    private func pronunciationChip(_ word: Word) -> some View {
        HStack(spacing: 8) {
            Text(word.phonetic)
            Button(action: viewModel.pronounceCurrentWord) {
                Image(systemName: "speaker.wave.2.fill")
            }
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial, in: Capsule())
    }

    private var doubleTapGesture: some Gesture {
        TapGesture(count: 2).onEnded {
            guard viewModel.state == .word, viewModel.currentWord != nil else { return }
            viewModel.likeCurrentWord()
            triggerHeartBurst()
        }
    }

    @ViewBuilder
    private var heartBurstOverlay: some View {
        if showHeartBurst {
            Image(systemName: "heart.fill")
                .font(.system(size: 110))
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.25), radius: 12)
                .transition(.scale(scale: 0.6).combined(with: .opacity))
        }
    }

    private func triggerHeartBurst() {
        withAnimation(.easeOut(duration: 0.15)) { showHeartBurst = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeOut(duration: 0.3)) { showHeartBurst = false }
        }
    }

    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 12)
            .onChanged { value in
                guard viewModel.state == .word else { return }
                if dragOffset == 0 {
                    HapticManager.shared.fire(.feedTransitionStarted)
                }
                let isAtStart = viewModel.currentIndex == 0 && value.translation.height > 0
                dragOffset = isAtStart ? value.translation.height * 0.35 : value.translation.height

                let crossed = abs(dragOffset) > commitThreshold
                if crossed, !hasFiredThresholdHaptic {
                    HapticManager.shared.fire(.feedTransitionCommitted)
                    hasFiredThresholdHaptic = true
                } else if !crossed {
                    hasFiredThresholdHaptic = false
                }
            }
            .onEnded { value in
                hasFiredThresholdHaptic = false

                if viewModel.state == .intro {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewModel.dismissIntro()
                    }
                    return
                }

                if value.translation.height < -commitThreshold {
                    transitionEdge = .top
                    withAnimation(.easeInOut(duration: 0.25)) {
                        viewModel.advance()
                        dragOffset = 0
                    }
                } else if value.translation.height > commitThreshold, viewModel.currentIndex > 0 {
                    transitionEdge = .bottom
                    withAnimation(.easeInOut(duration: 0.25)) {
                        viewModel.goBack()
                        dragOffset = 0
                    }
                } else {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                        dragOffset = 0
                    }
                }
            }
    }

    private var feedTransition: AnyTransition {
        .asymmetric(
            insertion: .move(edge: transitionEdge == .top ? .bottom : .top).combined(with: .opacity),
            removal: .move(edge: transitionEdge).combined(with: .opacity)
        )
    }

    private var header: some View {
        HStack {
            CircleIconButton(systemImage: "person.crop.circle", action: {})
            Spacer()
            progressCapsule
            Spacer()
            CircleIconButton(systemImage: "crown", action: {})
        }
        .padding(.horizontal, 20)
    }

    private var progressCapsule: some View {
        HStack(spacing: 10) {
            Image(systemName: "bookmark")
            Text(viewModel.progressLabel)
                .font(.callout.weight(.semibold))
            ProgressView(value: viewModel.progress)
                .tint(.white)
                .frame(width: 70)
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial, in: Capsule())
    }

    private var introView: some View {
        VStack(spacing: 30) {
            Spacer()
            VStack(spacing: 18) {
                Spacer()
                Text("Welcome")
                    .font(.system(size: 52, weight: .bold, design: .serif))
                    .foregroundStyle(.white)
                Spacer()
                VStack(spacing: 8) {
                    Image(systemName: "chevron.up")
                        .font(.system(size: 22, weight: .bold))
                        .offset(y: animateArrow ? -10 : 8)
                    Text("Swipe up")
                        .font(.headline)
                        .foregroundStyle(.white.opacity(0.9))
                }
            }
            Spacer()
        }
        .foregroundStyle(.white)
    }

    private var bottomActions: some View {
        HStack(spacing: 28) {
            Button(action: { showWordDetail = true }) {
                actionIcon("info.circle")
            }

            if let word = viewModel.currentWord {
                ShareLink(item: "\(word.term) (\(word.phonetic)) — \(word.definition)") {
                    actionIcon("square.and.arrow.up")
                }
            }

            Button(action: viewModel.toggleLike) {
                actionIcon(viewModel.isCurrentWordLiked ? "heart.fill" : "heart")
                    .foregroundStyle(viewModel.isCurrentWordLiked ? AppTheme.Colors.danger : .white)
            }

            Button(action: viewModel.toggleSave) {
                actionIcon(viewModel.isCurrentWordSaved ? "bookmark.fill" : "bookmark")
                    .foregroundStyle(viewModel.isCurrentWordSaved ? AppTheme.Colors.accentSecondary : .white)
            }
        }
        .animation(.easeOut(duration: 0.15), value: viewModel.isCurrentWordLiked)
        .animation(.easeOut(duration: 0.15), value: viewModel.isCurrentWordSaved)
    }

    private func actionIcon(_ systemImage: String) -> some View {
        Image(systemName: systemImage)
            .font(.title2)
            .foregroundStyle(.white)
            .frame(width: 54, height: 54)
            .background(.ultraThinMaterial, in: Circle())
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 44))
                .foregroundStyle(AppTheme.Colors.accentSecondary)
            Text("You're all caught up")
                .font(AppTheme.Typography.headline)
                .foregroundStyle(.white)
            Text("Come back tomorrow for a fresh set of words.")
                .font(AppTheme.Typography.body)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 40)
    }
}

struct CircleIconButton: View {
    let systemImage: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 52, height: 52)
                .background(.ultraThinMaterial, in: Circle())
        }
    }
}
