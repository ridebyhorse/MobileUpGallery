//
//  Builder.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import UIKit

final class Builder {
    static func makeRootRouter(_ scene: UIWindowScene) -> RootRouter {
        RootRouter(UIWindow(windowScene: scene), builder: Builder())
    }
    
    func buildLogin() -> LoginController {
        let presenter = LoginPresenter()
        let controller = LoginController(presenter: presenter)
        presenter.view = controller
        return controller
    }
    
    func buildGallery() -> GalleryController {
        let presenter = GalleryPresenter()
        let controller = GalleryController(presenter: presenter)
        presenter.view = controller
        return controller
    }
}
