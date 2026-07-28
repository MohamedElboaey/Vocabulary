# Task 2

## UX Improvement

- The current experience presents vocabulary in a continuous feed without reinforcing previously learned words. As users continue swiping, earlier words can be forgotten quickly, limiting long-term retention. Introducing periodic review moments improves the learning experience while preserving the simplicity and flow of the app.

## Missing Feature

- I implemented a **Smart Learning Quiz** feature that introduces short interactive quizzes during the learning journey. The feature includes both **Recall** and **Scramble** quizzes, which are generated from recently learned words instead of only the current word. This encourages active recall, reinforces memory through spaced review, and increases user engagement without disrupting the existing swipe-based experience.

### Implementation Notes

- Added two quiz types:
  - **Recall Quiz** – challenges users to match a definition with the correct word.
  - **Scramble Quiz** – challenges users to reconstruct a previously learned word from shuffled letters.
- Introduced a reusable quiz generation engine with a shared architecture, making it easy to add future quiz types while keeping the `HomeViewModel` focused on presentation logic and maintaining a clean architecture.
