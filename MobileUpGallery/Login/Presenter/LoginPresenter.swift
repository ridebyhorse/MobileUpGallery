//
//  LoginPresenter.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import UIKit
import VKID

protocol LoginControllerProtocol: UIViewController {
    func setupAuth(vkid: VKID?, onAuth: ((AuthResult) -> Void)?)
}

final class LoginPresenter {
    weak var view: LoginControllerProtocol?
    var router: RootRouter?
    
    func activate() {
        view?.setupAuth(vkid: AuthenticationManager.shared.vkid, onAuth: AuthenticationManager.shared.auth)
        setNotification()
    }
    
    func authComplete() {
        
    }
    
    @objc private func handleCurrentUser(_ notification: Notification) {
        guard let isLoggedIn = notification.userInfo?["isLoggedIn"] as? Bool else { return }
        if isLoggedIn {
            router?.showGallery()
        }
    }
}

private extension LoginPresenter {
    func setNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleCurrentUser),
            name: .init("currentUserDidChanged"),
            object: nil
        )
    }
}
