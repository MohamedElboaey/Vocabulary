
import SwiftUI

struct ThemedBackground: View {
    let theme: ReadingTheme
    
    var body: some View {
        Image(theme.backgroundImage)
            .resizable()
            .scaledToFill()
    }
}
