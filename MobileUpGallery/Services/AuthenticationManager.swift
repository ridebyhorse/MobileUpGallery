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
    
    var currentSession: UserSession?
    var vkid: VKID?
    var isLoggedIn = false
    var currentUser: User? {
        didSet {
            postUserNotification()
        }
    }
    
    private init() {}
    
    func setup() throws {
        do {
            vkid = try VKID(
                config: Configuration(
                    appCredentials: AppCredentials(
                        clientId: clientId,
                        clientSecret: clientSecret
                    )
                )
            )
            vkid?.add(observer: AuthenticationManager.shared)
        } catch {
            preconditionFailure("Failed to initialize VKID: \(error)")
        }
        
        currentSession = vkid?.currentAuthorizedSession
        guard let currentSession else { return }
        
        do {
            try updateSessionToken()
            try fetchUser()
        }
        catch {
            throw error
        }
    }
    
    func auth(authResult: AuthResult) throws {
        do {
            let session = try authResult.get()
            currentSession = vkid?.currentAuthorizedSession
            do {
                try fetchUser()
            }
            catch {
                throw error
            }
            print("Auth succeeded with token: \(session.accessToken)")
        } catch AuthError.cancelled {
            print("Auth cancelled by user")
            throw AuthError.cancelled
        } catch {
            print("Auth failed with error: \(error)")
            throw error
        }
    }
    
    func logOut() {
        currentSession?.logout { [weak self] result in
            print("Did logout from \(self?.currentSession?.sessionId ?? "") with \(result)")
        }
    }
    
    private func fetchUser() throws {
        var userFetchingError: Error?
        
        vkid?.currentAuthorizedSession?.fetchUser { [weak self] result in
            do {
                let user = try result.get()
                print(user.firstName ?? "name")
                print(user.lastName ?? "surname")
                self?.currentUser = user
            } catch {
                userFetchingError = error
                print("Failed to fetch user info")
            }
        }
        
        if let userFetchingError {
            throw userFetchingError
        }
    }
    
    private func updateSessionToken() throws {
        var tokenRefreshError: Error?
        
        vkid?.currentAuthorizedSession?.getFreshAccessToken { [weak self] result in
            do {
                let (accessToken, refreshToken) = try result.get()
                self?.isLoggedIn = true
            } catch {
                tokenRefreshError = error
                print("Refreshing access token failed")
            }
        }
        
        if let tokenRefreshError {
            throw tokenRefreshError
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

extension AuthenticationManager: VKIDObserver {
    func vkid(_ vkid: VKID, didLogoutFrom session: UserSession, with result: LogoutResult) {
           print("Did logout from \(session) with \(result)")
       }

       func vkid(_ vkid: VKID, didStartAuthUsing oAuth: OAuthProvider) {
           print("Authorization started")
       }

       func vkid(_ vkid: VKID, didCompleteAuthWith result: AuthResult, in oAuth: OAuthProvider) {
           print("Authorization completed wuth \(result)")
       }

       func vkid(_ vkid: VKID, didRefreshAccessTokenIn session: UserSession, with result: TokenRefreshingResult) {
           print("Did refresh token in \(session) with \(result)")
           switch result {
           case .success((_, _)):
               isLoggedIn = true
           case .failure(let tokenRefreshingError):
               print(tokenRefreshingError.localizedDescription)
           }
       }

       func vkid(_ vkid: VKID, didUpdateUserIn session: UserSession, with result: UserFetchingResult) {
           print("Did update user in \(session) with \(result)")
       }
}
