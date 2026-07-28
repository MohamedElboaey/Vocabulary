
import Foundation

struct LearningSession {
    let recentWords: [Word]
    let allWords: [Word]
    
    var reviewWords: [Word] {
            Array(recentWords.dropLast())
        }
    
    func randomReviewWord() -> Word? {
            reviewWords.randomElement()
        }
}
