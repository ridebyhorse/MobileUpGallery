//
//  GalleryPresenter.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import Foundation
import VKID

protocol GalleryControllerProtocol: AnyObject {
    func update(with user: User?, photos: [Photo], videos: [Video])
    func didUpdatePhotos()
    func insertPhotos(at indexPaths: [IndexPath])
    func didUpdateVideos()
    func insertVideos(at indexPaths: [IndexPath])
}

final class GalleryPresenter {
    weak var view: GalleryControllerProtocol?
    var router: RootRouter?
    private var photos = [Photo]()
    private var videos = [Video]()
    
    func activate() {
        setNotification()
        
        getVideos()
        getPhotos()
    }
    
    func signOut() {
        AuthenticationManager.shared.logOut()
        router?.startLogin()
    }
    
    func selectPhoto(_ id: Int) {
        router?.push(PhotoDetailController(photo: photos[id]))
    }
    
    func selectVideo(_ id: Int) {
        router?.push(VideoDetailController(video: videos[id]))
    }
    
    func loadPhotos() {
        
    }
    
    func loadVideos() {
        
    }
    
    private func getPhotos() {
        Task {
            do {
                photos = try await NetworkManager.shared.fetchPhotos()
                print(photos)
                print(videos.count)
                view?.update(with: AuthenticationManager.shared.currentUser, photos: photos, videos: videos)
                await updateView(with: photos)
                await updateView(with: videos)
            }
            catch {
                print(error)
            }
        }
    }
    
    private func getVideos() {
        videos = MockVideo.getMockVideo()
    }
    
    @objc private func handleCurrentUser(_ notification: Notification) {
        guard let isLoggedIn = notification.userInfo?["isLoggedIn"] as? Bool else { return }
        if isLoggedIn {
            view?.update(with: AuthenticationManager.shared.currentUser, photos: photos, videos: videos)
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
    
    
    @MainActor
    func updateView(with newPhotos: [Photo]) {
        if photos.count == newPhotos.count {
            /// if photos load first
            view?.didUpdatePhotos()
        } else {
            /// if photo load after scroll
            let startIndex = photos.count - newPhotos.count
            let endIndex = photos.count - 1
            let indexPaths = (startIndex...endIndex).map {
                IndexPath(item: $0, section: 0)
            }
            view?.insertPhotos(at: indexPaths)
        }
    }
    
    @MainActor
    func updateView(with newVideos: [Video]) {
        if videos.count == newVideos.count {
            /// if videos load first
            view?.didUpdateVideos()
        } else {
            /// if video load after scroll
            let startIndex = videos.count - newVideos.count
            let endIndex = videos.count - 1
            let indexPaths = (startIndex...endIndex).map {
                IndexPath(item: $0, section: 0)
            }
            view?.insertVideos(at: indexPaths)
        }
    }
}
