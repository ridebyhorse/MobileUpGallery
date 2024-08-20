//
//  AuthenticationManager.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import Foundation
import VKID

final class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    private let clientId = "52171977"
    private let clientSecret = "GacA3WtYrWTmPjkL1QEv"
    
    var currentUser: User? {
        didSet {
            postUserNotification()
        }
    }
    var currentSession: UserSession?
    var vkid: VKID?
    
    private init() {}
    
    func setup() {
        do {
            vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: clientId,         // ID вашего приложения
                        clientSecret: clientSecret  // ваш защищенный ключ (client_secret)
                    )
                )
            )            
        } catch {
            preconditionFailure("Failed to initialize VKID: \(error)")
        }
    }
    
    func auth(authResult: AuthResult) {
        //Обработка результата авторизации.
        do {
            let session = try authResult.get()
            fetchUser()
            print("Auth succeeded with token: \(session.accessToken)")
        } catch AuthError.cancelled {
            print("Auth cancelled by user")
        } catch {
            print("Auth failed with error: \(error)")
        }
    }
    
    private func fetchUser() {
        vkid?.currentAuthorizedSession?.fetchUser { [weak self] result in
            do {
                let user = try result.get()
                print(user.firstName)
                print(user.lastName)
                self?.currentUser = user
            } catch {
                print("Failed to fetch user info")
            }
        }
    }
}

private extension AuthenticationManager {
    func postUserNotification() {
        NotificationCenter.default.post(
            name: .init("currentUserDidChanged"),
            object: nil,
            userInfo: ["isLoggedIn": currentUser != nil]
        )
    }
}
