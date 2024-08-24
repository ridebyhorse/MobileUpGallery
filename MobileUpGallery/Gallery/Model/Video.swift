//
//  Video.swift
//  MobileUpGallery
//
//  Created by Мария Нестерова on 24.08.2024.
//

import Foundation

struct VideoResponse: Decodable {
    let response: Videos
}

struct Videos: Decodable {
    let count: Int
    let items: [Video]
}

struct Video: Decodable {
    let id: Int
    let image: [VideoPreview]
    let title: String
    let player: String
}

struct VideoPreview: Decodable {
    let url: String
}
