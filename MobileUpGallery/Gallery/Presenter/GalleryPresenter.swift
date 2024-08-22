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
    var router: RootRouter?
    
    func activate() {
        view?.update(with: AuthenticationManager.shared.currentUser)
        setNotification()
    }
    
    func signOut() {
        AuthenticationManager.shared.logOut()
        router?.startLogin()
    }
    
    @objc private func handleCurrentUser(_ notification: Notification) {
        guard let isLoggedIn = notification.userInfo?["isLoggedIn"] as? Bool else { return }
        if isLoggedIn {
            view?.update(with: AuthenticationManager.shared.currentUser)
        }
    }
}

private extension GalleryPresenter {
    func setNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleCurrentUser),
            name: .init("currentUserDidChanged"),
            object: nil
        )
    }
}
