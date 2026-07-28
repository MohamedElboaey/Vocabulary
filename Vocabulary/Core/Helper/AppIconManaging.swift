
import UIKit

protocol AppIconManaging {
    func updateIcon(_ style: AppIconStyle)
}

final class AppIconManager: AppIconManaging {

    func updateIcon(_ style: AppIconStyle) {

        guard UIApplication.shared.supportsAlternateIcons else {
            return
        }

        UIApplication.shared.setAlternateIconName(style.alternateIconName) { error in

            if let error {
                print("❌ App Icon Error:", error.localizedDescription)
            }

        }

    }

}
