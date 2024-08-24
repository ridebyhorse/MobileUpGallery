//
//  Photo.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 22.08.2024.
//

import Foundation

struct PhotoAlbumsResponse: Decodable {
    let response: PhotoAlbums
}

struct PhotoAlbums: Decodable {
    let count: Int
    let items: [PhotoAlbum]
}

struct PhotoAlbum: Decodable {
    let id: Int
}

struct PhotoResponse: Decodable {
    let response: Photos
}

struct Photos: Decodable {
    let count: Int
    let items: [Photo]
}

struct Photo: Decodable {
    let id: Int
    let date: Int
    let sizes: [PhotoSize]
}

struct PhotoSize: Decodable {
    let height: Int
    let url: String
}
