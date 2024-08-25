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
    private let videoUrl = "https://api.vk.ru/method/video.get?owner_id=-128666765&v=5.199&access_token="
    private let albumParamUrl = "&album_id="
    
    private var albumIds = [Int]()
    private var photos = [Photo]()
    private var videos = [Video]()
    
    private init() {}
    
    func fetchPhotos() async throws -> [Photo] {
        let token = AuthenticationManager.shared.currentSession?.accessToken.value ?? ""
        let albumsUrlString = albumsUrl + token
        
        guard let albumsUrl = URL(string: albumsUrlString) else {
            throw URLError(.badURL)
        }
        
        do {
            let (albumsData, _) = try await URLSession.shared.data(from: albumsUrl)
            let albumsResponse = try JSONDecoder().decode(PhotoAlbumsResponse.self, from: albumsData)
            albumIds = albumsResponse.response.items.map({$0.id})
            for id in albumIds {
                let photoUrlString = photoUrl + token + albumParamUrl + String(id)
                
                guard let url = URL(string: photoUrlString) else { throw URLError(.badURL) }
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let photoResponse = try JSONDecoder().decode(PhotoResponse.self, from: data)
                    photos += photoResponse.response.items
                } 
                catch {
                    throw error
                }
            }
        } 
        catch {
            throw error
        }
        
        return photos
    }
    
    func fetchVideos() async throws -> [Video] {
        let token = AuthenticationManager.shared.currentSession?.accessToken.value ?? ""
        let urlString = videoUrl + token
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let videoResponse = try JSONDecoder().decode(VideoResponse.self, from: data)
            videos.append(contentsOf: videoResponse.response.items)
        }
        catch {
            print(error)
            print("User ID has no access to video")
            videos = MockVideo.getMockVideo()
        }
        
        return videos
    }
}
