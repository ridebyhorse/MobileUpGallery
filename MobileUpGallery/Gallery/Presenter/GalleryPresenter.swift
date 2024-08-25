//
//  GalleryPresenter.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 20.08.2024.
//

import Foundation
import VKID

protocol GalleryControllerProtocol: AnyObject, LoadingPresenting {
    func updatePhotos(photos: [Photo])
    func updateVideos(videos: [Video])
}

final class GalleryPresenter {
    weak var view: GalleryControllerProtocol?
    var router: RootRouter?
    private var photos = [Photo]()
    private var videos = [Video]()
    
    func activate() {
//        setNotification()
        view?.showLoading()
        
        getMedia()
//        getVideos()
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
    
    private func getMedia() {
        Task {
            await fetchMedia()
        }
    }
    
    private func fetchMedia() async {
        await withTaskGroup(of: Void.self) { taskGroup in
            taskGroup.addTask { [weak self] in
                do {
                    self?.photos = try await NetworkManager.shared.fetchPhotos()
                    await self?.updateView(with: self?.photos ?? [Photo]())
                }
                catch {
                    print(error)
                }
            }
        }
        getVideos()
    }
    
    private func getVideos() {
        Task {
            do {
                videos = try await NetworkManager.shared.fetchVideos()
                await updateView(with: videos)
            }
            catch {
                print(error)
            }
        }
    }
}

private extension GalleryPresenter {
    @MainActor
    func updateView(with newPhotos: [Photo]) {
        view?.hideLoading()
        view?.updatePhotos(photos: newPhotos)
    }
    
    @MainActor
    func updateView(with newVideos: [Video]) {
        view?.updateVideos(videos: newVideos)
    }
}
