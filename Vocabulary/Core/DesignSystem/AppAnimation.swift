import SwiftUI

enum AppAnimation {

    static let spring = Animation.spring(
        duration: 0.45,
        bounce: 0.28
    )

    static let smooth = Animation.easeInOut(duration: 0.3)
}