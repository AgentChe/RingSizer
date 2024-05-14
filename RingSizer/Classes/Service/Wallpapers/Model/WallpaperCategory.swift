//
//  WallpaperCategory.swift
//  GBEmulator
//
//  Created by Андрей Чернышев on 26.04.2024.
//

import Foundation

struct WallpaperCategory {
    let id: Int
    let name: String
    let imageUrl: URL
    let wallpapers: [Wallpaper]
    
    init?(json: [String: Any]) {
        guard
            let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let imagePath = json["image_url"] as? String,
            let imageUrl = URL(string: imagePath),
            let wallpapersArray = json["wallpapers"] as? [[String: Any]]
        else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.wallpapers = wallpapersArray.compactMap { json -> Wallpaper? in
            Wallpaper(json: json)
        }
    }
}

extension WallpaperCategory {
    static func map(from response: Any) -> [WallpaperCategory] {
        guard
            let json = response as? [String: Any],
            let data = json["_data"] as? [String: Any],
            let categoriesArray = data["categories"] as? [[String: Any]]
        else {
            return []
        }
        
        return categoriesArray.compactMap { json -> WallpaperCategory? in
            WallpaperCategory(json: json)
        }
    }
}
