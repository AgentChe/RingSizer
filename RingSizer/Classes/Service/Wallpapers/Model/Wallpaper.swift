//
//  Wallpaper.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import Foundation

struct Wallpaper {
    let id: Int
    let name: String
    let thumbImageUrl: URL
    let imageUrl: URL
    
    init?(json: [String: Any]) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let thumbImagePath = json["thumb_image_url"] as? String,
            let thumbImageUrl = URL(string: thumbImagePath),
            let imagePath = json["image_url"] as? String,
            let imageUrl = URL(string: imagePath)
        else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.thumbImageUrl = thumbImageUrl
        self.imageUrl = imageUrl
    }
}
