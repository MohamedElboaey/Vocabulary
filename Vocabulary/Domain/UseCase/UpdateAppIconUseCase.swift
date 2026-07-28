

import Foundation

protocol UpdateAppIconUseCaseProtocol {

    func execute(style: AppIconStyle)
}

struct DefaultUpdateAppIconUseCase: UpdateAppIconUseCaseProtocol {

    private let manager: AppIconManaging

    init(manager: AppIconManaging) {
        self.manager = manager
    }

    func execute(style: AppIconStyle) {
        manager.updateIcon(style)
    }
}
