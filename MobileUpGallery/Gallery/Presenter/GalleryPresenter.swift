//
//  GalleryPresenter.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import Foundation
import VKID

protocol GalleryControllerProtocol: AnyObject {
    func update(with user: User?)
}

final class GalleryPresenter {
    weak var view: GalleryControllerProtocol?
    
    func activate() {
        view?.update(with: AuthenticationManager.shared.currentUser)
    }
}
