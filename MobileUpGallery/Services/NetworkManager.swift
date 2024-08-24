//
//  NetworkManager.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 22.08.2024.
//

import Foundation
import VKIDCore
import VKID

final class NetworkManager {
    static let shared = NetworkManager()
    private let albumsUrl = "https://api.vk.ru/method/photos.getAlbums?owner_id=-128666765&v=5.199&access_token="
    private let photoUrl = "https://api.vk.ru/method/photos.get?owner_id=-128666765&v=5.199&access_token="
    private let albumParamUrl = "&album_id="
    
    private var albumIds = [Int]()
    private var photos = [Photo]()
    
    private init() {}
    
    func fetchPhotos() async throws -> [Photo] {
        let token = AuthenticationManager.shared.currentSession?.accessToken.value ?? ""
        let albumsUrlString = albumsUrl + token
        guard let albumsUrl = URL(string: albumsUrlString) else {
            throw URLError(.badURL)
        }
        let (albumsData, _) = try await URLSession.shared.data(from: albumsUrl)
        let albumsResponse = try JSONDecoder().decode(PhotoAlbumsResponse.self, from: albumsData)
        albumIds = albumsResponse.response.items.map({$0.id})
        for id in albumIds {
            let photoUrlString = photoUrl + token + albumParamUrl + String(id)
            guard let url = URL(string: photoUrlString) else {
                throw URLError(.badURL)
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: data)
            photos.append(contentsOf: photoResponse.response.items)
        }
        
        return photos
    }
}
